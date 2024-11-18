import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app.config.dart';
import '../../../data/service/api.service.dart';

class CustomerController extends GetxController{

  RxList selectedRole = [].obs;

  RxBool isShippingAddress = false.obs;

  //test input filed
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> companyController = TextEditingController().obs;
  Rx<TextEditingController> brandController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> postCodeController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> stratController = TextEditingController().obs;
  Rx<TextEditingController> contactFacturation = TextEditingController().obs;
  Rx<TextEditingController> contactComptabilit = TextEditingController().obs;
  Rx<TextEditingController> contactEmail = TextEditingController().obs;
  Rx<TextEditingController> contactPhone = TextEditingController().obs;


  Rx<TextEditingController> shippingPhone = TextEditingController().obs;
  Rx<TextEditingController> shippingEmail = TextEditingController().obs;
  Rx<TextEditingController> shippingCity = TextEditingController().obs;
  Rx<TextEditingController> shippingPostCode = TextEditingController().obs;
  Rx<TextEditingController> shippingAddress = TextEditingController().obs;
  Rx<TextEditingController> shippingMessage = TextEditingController().obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  //signup
  RxBool isSignUp = false.obs;
  Future createAccount()async{
    isSignUp.value = true;
    var data = {
      "name": contactFacturation.value.text,
      "email": emailController.value.text,
      "password": "12345678",
      "account_email": emailController.value.text,
      "account_phone": contactPhone.value.text,
      "account_type": selectedRole[0],
      "brand": brandController.value.text,
      "city": cityController.value.text,
      "company": companyController.value.text,
      "contract_comptabilité": "N/A",
      "contract_facturation": contactFacturation.value.text,
      "post_code":postCodeController.value.text,
      "siret": stratController.value.text
    };
    print("body  =---- ${data}");
    var response = await http.post(Uri.parse(AppConfig.NEW_CUSTOMER),
        body: jsonEncode(data),
        headers: {
          "Accept" : "application/json",
          "Content-Type" : "application/json"
        }
    );

    print("response ===== ${response.statusCode}");
    print("response body===== ${response.body}");

    if(response.statusCode == 200){
      if(isShippingAddress.value) {
        addAddress(jsonDecode(response.body)["token"]);
      }else{
        isSignUp.value = false;
      }
    }else{
      isSignUp.value = false;
      Get.snackbar("Error!", "Something went wrong with server.", backgroundColor: Colors.red);
    }

  }


  Future addAddress(id) async {
    var data = {
      "phone": shippingPhone.value.text, // Extract .text
      "contact": shippingEmail.value.text, // Extract .text
      "address": shippingAddress.value.text, // Extract .text
      "address_type": "home",
      "city": shippingCity.value.text, // Extract .text
      "post_code": shippingPostCode.value.text, // If post_code is a TextEditingController, use .text
      "message": shippingMessage.value.text, // Extract .text
    };

    print("data --- ${data}");

    var res = await http.post(
      Uri.parse(AppConfig.ADD_DELIVERY_ADDRESS+"${id}"),
      body: jsonEncode(data),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      clearAllInputFeild();
      Get.snackbar("Success!", "Account has been created.", backgroundColor: Colors.green);

      isSignUp.value = false;
    } else {
      isSignUp.value = false;
      Get.snackbar("Error!", "Something went wrong when trying to add address.",
          backgroundColor: Colors.red);
    }
  }











  //clear all input feild
  clearAllInputFeild(){
    name.value.clear();
    emailController.value.clear();
    usernameController.value.clear();
    passwordController.value.clear();
    companyController.value.clear();
    brandController.value.clear();
    addressController.value.clear();
    postCodeController.value.clear();
    cityController.value.clear();
    stratController.value.clear();
    contactFacturation.value.clear();
    contactComptabilit.value.clear();
    contactEmail.value.clear();
    contactPhone.value.clear();
    shippingPhone.value.clear();
    shippingEmail.value.clear();
    shippingCity.value.clear();
    shippingPostCode.value.clear();
    shippingAddress.value.clear();
    shippingMessage.value.clear();

  }


  //logout
  logout()async{

  }

}