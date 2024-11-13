import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../app.config.dart';
import '../../../data/model/admin.role.list.model.dart';
import '../../../data/model/all_admin_model.dart';
import '../../../data/service/api.service.dart';

class AdminRoleController extends GetxController{

  RxList<SingleAdmin> allAdminList = <SingleAdmin>[].obs;


  RxList<bool> isSelected = <bool>[].obs;
  RxBool isEdit = false.obs;
  RxString selectedId = "".obs;
  // admin role list  ----------
  RxBool isRoleLoading = false.obs;
  Rx<AdminRoleListModel> adminRoleListModel = AdminRoleListModel().obs;
  Rx<SingleAdminRole> selectedSingleAdminRole = SingleAdminRole().obs;
  getAllRoleList()async{
    isRoleLoading.value = true;
    var res = await ApiService().getApi(AppConfig.ADMIN_ROLE_GET);
    if(res.statusCode ==200){
      adminRoleListModel.value = AdminRoleListModel.fromJson(jsonDecode(res.body));
      selectedSingleAdminRole.value = adminRoleListModel.value.data![0];
    }
    isRoleLoading.value = false;
  }
// admin role list  ----------



  RxBool isCreatingAdmin = false.obs; 
  Rx<TextEditingController> firstName = TextEditingController().obs; 
  Rx<TextEditingController> lastName = TextEditingController().obs; 
  Rx<TextEditingController> email = TextEditingController().obs; 
  Rx<TextEditingController> pass = TextEditingController().obs; 
  RxString roleId = "".obs;
  
  createNewAdmin()async{
    isCreatingAdmin.value = true;
    var data = {
      "first_name": firstName.value.text,
      "last_name": lastName.value.text,
      "email": email.value.text, 
      "password": pass.value.text,
      "role_id": selectedSingleAdminRole.value.roleId.toString()
    };
    var res = await ApiService().postApi(AppConfig.ADMIN_SIGNUP, data);
    if(res.statusCode == 200){
      clearAll();
      Get.snackbar("Success!", "New admin create and permission generate!", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isCreatingAdmin.value = false;
  }


  //get all admin
  RxBool isGettingAllAdmin = false.obs;
  Rx<AllAdminListModel> allAdminListModel = AllAdminListModel().obs;
  getAllAdmin()async{
    isGettingAllAdmin.value = true;
    var res = await ApiService().getApi(AppConfig.ADMIN_GET_ALL);
    if(res.statusCode == 200){
      allAdminListModel.value = AllAdminListModel.fromJson(jsonDecode(res.body));
      allAdminList.value = allAdminListModel.value.data!;
    }
    isGettingAllAdmin.value = false;
  }


  //delete admion
  deleteAdmin(int id)async{
    var res = await ApiService().deleteApi("${AppConfig.ADMIN_DELETE}$id");
    if(res.statusCode == 200){
      getAllAdmin();
      Get.snackbar("Success!", "Admin deleted successfully!", backgroundColor: Colors.green);

    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
  }

  //search admin
  RxBool isSearchingAdmin = false.obs;
  searchAdmin(String query)async{
    isSearchingAdmin.value = true;
    if(query.isEmpty){
      allAdminList.value = allAdminListModel.value.data!;
      isSearchingAdmin.value = false;
      update();
      return;
    }else{
      allAdminList.value = allAdminListModel.value.data!.where((order) =>
      order.firstName!.toLowerCase().contains(query.toLowerCase()) ||  order.lastName!.toLowerCase().contains(query.toLowerCase()) ||   order.email!.toLowerCase().contains(query.toLowerCase())// Assuming companyName is a field in OrderModel
      ).toList(); // Convert the Iterable to a List
    }

    isSearchingAdmin.value = false;
    update();
  }


  //update admin
  RxBool isUpdatingAdmin = false.obs;
  updateAdmin( id)async{
    isUpdatingAdmin.value = true;
    var data = {
      "first_name": firstName.value.text,
      "last_name": lastName.value.text,
      "email": email.value.text,
      "role_id": selectedSingleAdminRole.value.roleId.toString()
    };
    var res = await ApiService().putApi("${AppConfig.ADMIN_UPDATE}$id", data);
    if(res.statusCode == 200){
      clearAll();
      Get.snackbar("Success!", "Admin updated successfully!", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isUpdatingAdmin.value = false;
  }



  //set value to edit
  setValueToEdit(SingleAdmin singleAdmin){
    isEdit.value = true;
    firstName.value.text = singleAdmin.firstName!;
    lastName.value.text = singleAdmin.lastName!;
    email.value.text = singleAdmin.email!;
    selectedId.value = singleAdmin.id.toString();
   // roleId.value = singleAdmin.roleName.toString();
  }



  //clear all
  clearAll(){
    selectedId.value = "";
   firstName.value.clear();
   lastName.value.clear();
   email.value.clear();
   pass.value.clear();
   roleId.value = "";
  }




}