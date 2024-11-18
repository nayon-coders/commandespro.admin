import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

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
  RxList<String> selectedAccountType = <String>[].obs;
  RxList<String> selectedAccountStatus = <String>[].obs;





  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;
  Rx<UserListModel> userListModel = UserListModel().obs;
  Rx<UserList> selectedUser = UserList().obs;
  RxList<UserList> newUserList = <UserList>[].obs;
  RxList<UserList> blockUserList = <UserList>[].obs;
  RxList<UserList> activeUserList = <UserList>[].obs;
  RxList<UserList> allUserList = <UserList>[].obs;

  Rx<SingleCustomerModel> singleCustomerModel = SingleCustomerModel().obs;

  //get all user
  getAllUser(String page)async{
    isLoading.value = true;

    var res = await ApiService().getApi(AppConfig.USER_GET);
    if(res.statusCode == 200){
      activeUserList.value.clear();
      blockUserList.value.clear();
      newUserList.value.clear();
      allUserList.clear();
      clearTextField();
      userListModel.value = UserListModel.fromJson(jsonDecode(res.body));
      for(var i in userListModel.value.data!){
        allUserList.value.add(i); // Add all data to the list
        storeDataIntoList(allUserList); // Store data into the list
         if(i.status == "Active"){
          selectedUser.value = i;
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
  updateUserStatus(id, status, index)async{
    isUpdating.value = true;
    var data = {
      "status" : status
    };
    var res = await ApiService().putApi(AppConfig.USER_STATUS_UPDATE+"${id}", data);
    if(res.statusCode == 200){
      getAllUser("1");
    //  Get.snackbar("Success!", "User status is update. Status: ${status}" ,backgroundColor: Colors.green);
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
  updateUser(id, index)async{
    isUpdating.value = true;
    var data = {
      "name" : nameControllerList.value[index].text,
      "accountPhone" : accountPhoneControllerList.value[index].text,
      "account_type" : selectedAccountType.value[index],
      "postCode" : postCodeControllerList.value[index].text,
    };
    print("data --- ${data}");
    var res = await ApiService().putApi(AppConfig.USER_UPDATE+"${id}", data);
    if(res.statusCode == 200){
      getAllUser("1");
      Get.snackbar("Success!", "User is updated successfully",backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isUpdating.value = false;
  }


  deleteUser(id)async{
    isLoading.value = true;
    var res = await ApiService().deleteApi(AppConfig.DELETE_USER+"${id}");
    if(res.statusCode == 200){

      getAllUser("1");
      Get.snackbar("Success!", "User is deleted successfully",backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isLoading.value = false;
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
  void searchCustomerByName(String query) {
    print("searching for $query");
    if(query.isEmpty){
      allUserList.value = userListModel.value.data!;
      update();
      return;
    } else {
      // Filter the orders based on the company name
      allUserList.value = allUserList.value.where((value) =>
          value.name!.toLowerCase().contains(query.toLowerCase())
         || value.company!.toLowerCase().contains(query.toLowerCase())
        || value.email!.toLowerCase().contains(query.toLowerCase())
        || value.accountPhone!.toLowerCase().contains(query.toLowerCase())
        || value.postCode!.toLowerCase().contains(query.toLowerCase())

      ).toList(); // Convert the Iterable to a List
    }
    print("searching for $searchResults");
    update();
  }


  // text editing controller list items
  RxList<TextEditingController> nameControllerList = <TextEditingController>[].obs;
  RxList<TextEditingController> emailControllerList = <TextEditingController>[].obs;
  RxList<TextEditingController> accountPhoneControllerList = <TextEditingController>[].obs;
  RxList<TextEditingController> postCodeControllerList = <TextEditingController>[].obs;

  //method: store data into this list
  void storeDataIntoList(List<UserList> userList) {
    clearTextField();
    for (var i in userList) {
      nameControllerList.add(TextEditingController(text: i.name));
      emailControllerList.add(TextEditingController(text: i.email));
      accountPhoneControllerList.add(TextEditingController(text: i.accountPhone));
      postCodeControllerList.add(TextEditingController(text: i.postCode));
      selectedAccountType.value.add(i.accountType!);
    }
  }
  //clear all text Editing controller
  void clearTextField() {
    nameControllerList.clear();
    emailControllerList.clear();
    accountPhoneControllerList.clear();
    postCodeControllerList.clear();
    selectedAccountType.clear();
  }





}