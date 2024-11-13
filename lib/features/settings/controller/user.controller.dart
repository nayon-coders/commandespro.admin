import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.config.dart';
import '../../../data/model/single_customer_model.dart';
import '../../../data/model/user.list.model.dart';
import '../../../data/service/api.service.dart';

class AppUserController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  @override
  void onReady() {
    // TODO: implement onClose
    super.onReady();
  }


  //text input controller
  // Defining Rx<TextEditingController> for each field
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> accountPhoneController = TextEditingController().obs;
  Rx<TextEditingController> brandController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> companyController = TextEditingController().obs;
  Rx<TextEditingController> contractComptabiliteController = TextEditingController().obs;
  Rx<TextEditingController> contractFacturationController = TextEditingController().obs;
  Rx<TextEditingController> postCodeController = TextEditingController().obs;
  Rx<TextEditingController> siretController = TextEditingController().obs;




  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;
  Rx<UserListModel> userListModel = UserListModel().obs;
  RxList<UserList> newUserList = <UserList>[].obs;
  RxList<UserList> blockUserList = <UserList>[].obs;
  RxList<UserList> activeUserList = <UserList>[].obs;

  Rx<SingleCustomerModel> singleCustomerModel = SingleCustomerModel().obs;

  //get all user
  getAllUser(String page)async{
    isLoading.value = true;
    var res = await ApiService().getApi(AppConfig.USER_GET);
    if(res.statusCode == 200){
      activeUserList.value.clear();
      blockUserList.value.clear();
      newUserList.value.clear();
      userListModel.value = UserListModel.fromJson(jsonDecode(res.body));
      for(var i in userListModel.value.data!){
        if(i.status == "Actif"){
          activeUserList.value.add(i);
        }else if(i.status == "Blacklist"){
          blockUserList.value.add(i);
        }else{
          newUserList.value.add(i);
        }
      }
    }
    isLoading.value = false;
  }


  //update user status
  updateUserStatus(id, status)async{
    isUpdating.value = true;
    var data = {
      "status" : status
    };
    var res = await ApiService().putApi(AppConfig.USER_STATUS_UPDATE+"${id}", data);
    if(res.statusCode == 200){
      getAllUser(userListModel.value.currentPage.toString());
      Get.back();
      Get.snackbar("Success!", "User status is update. Status: ${status}" ,backgroundColor: Colors.green);

    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isUpdating.value = false;
  }

  //get single user
  getSingleUser(id)async{
    isLoading.value = true;
    print("this is single user id --- ${id}");
    var res = await ApiService().getApi(AppConfig.USER_SINGLE+"${id}");
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      singleCustomerModel.value = SingleCustomerModel.fromJson(data);
      //set all textediting controller value
      nameController.value.text = singleCustomerModel.value.name!;
      emailController.value.text = singleCustomerModel.value.email!;
      accountPhoneController.value.text = singleCustomerModel.value.accountPhone!;
      brandController.value.text = singleCustomerModel.value.brand!;
      cityController.value.text = singleCustomerModel.value.city!;
      companyController.value.text = singleCustomerModel.value.company!;
      contractComptabiliteController.value.text = singleCustomerModel.value!.contractComptabilit!;
      contractFacturationController.value.text = singleCustomerModel.value.contractFacturation!;
      postCodeController.value.text = singleCustomerModel.value.postCode!;
      siretController.value.text = singleCustomerModel.value.siret!;

    }
    isLoading.value = false;
  }



  //update user with id
  updateUser(id)async{
    isUpdating.value = true;
    var data = {
      "name" : nameController.value.text,
      "email" : emailController.value.text,
      "accountPhone" : accountPhoneController.value.text,
      "brand" : brandController.value.text,
      "city" : cityController.value.text,
      "company" : companyController.value.text,
      "contractComptabilit" : contractComptabiliteController.value.text,
      "contractFacturation" : contractFacturationController.value.text,
      "postCode" : postCodeController.value.text,
      "siret" : siretController.value.text,
    };
    var res = await ApiService().putApi(AppConfig.USER_UPDATE+"${id}", data);
    if(res.statusCode == 200){
      getSingleUser(id);
      Get.snackbar("Success!", "User is updated successfully",backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isUpdating.value = false;
  }


  Color getCustomerStatusColor(String status) {
    switch (status) {
      case "En Attente": // Pending
        return Colors.orange; // Pending verification by CP

      case "Actif": // Active
        return Colors.green; // Validated by CP

      case "Inactif": // Inactive
        return Colors.red; // Cannot view prices or place orders

      case "Blacklist":
        return Colors.black; // Blacklisted, restricted from services

      default:
        return Colors.transparent; // Default if no match
    }
  }


  // New method to search orders by company name
  RxList searchResults = [].obs;
  void searchCustomerByName(String companyName, RxList<UserList> userList) {
    print("searching for $companyName");
    if (companyName.isEmpty) {
      // If the search input is empty, return all orders
      searchResults.value = userList.value.toList();
    } else {
      // Filter the orders based on the company name
      searchResults.value = userList.value.where((values) =>
          values.name!.toLowerCase().contains(companyName.toLowerCase()) // Assuming companyName is a field in OrderModel
      ).toList(); // Convert the Iterable to a List
    }
    print("searching for $searchResults");
    update();
  }




}