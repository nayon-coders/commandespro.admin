import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minia_web_project/app.config.dart';
import 'package:minia_web_project/controller/sidebar_controller.dart';
import 'package:minia_web_project/data/model/admin.role.list.model.dart';
import 'package:minia_web_project/data/model/all_admin_model.dart';
import 'package:minia_web_project/data/service/api.service.dart';

class AdminRoleController extends GetxController{

  SideBarController _sideBarController = Get.find<SideBarController>();


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
      "role_id": selectedSingleAdminRole.value.id.toString()
    };
    var res = await ApiService().postApi(AppConfig.ADMIN_SIGNUP, data);
    if(res.statusCode == 200){
      _sideBarController.index.value = 17;
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



  //clear all
  clearAll(){
   firstName.value.clear();
   lastName.value.clear();
   email.value.clear();
   pass.value.clear();
   roleId.value = "";
  }




}