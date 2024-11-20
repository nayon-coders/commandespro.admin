import 'dart:convert';

import 'package:commandespro_admin/app.config.dart';
import 'package:commandespro_admin/data/service/api.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UpdatePasswordController extends GetxController{
  Rx<TextEditingController> oldPass = TextEditingController().obs;
  Rx<TextEditingController> newPass =TextEditingController().obs;


  RxBool isUpdating = false.obs;

  passwordUpdate()async{

    isUpdating.value=true;

    final body ={
      "old_password":oldPass.value.text,
      "new_password":newPass.value.text,
    };
    final res = await ApiService().putApi(
        AppConfig.UPDATE_PASSWORD,
        body,

    );

    if(res.statusCode == 200){
      clearTextFiled();
      Get.snackbar("Success", "Password Update Successfully",backgroundColor: Colors.green,colorText: Colors.white);
    }else{
      Get.snackbar("Failed", "${jsonDecode(res.body)["message"]}",backgroundColor: Colors.red);
    }
    isUpdating.value = false;

  }

  clearTextFiled(){
    oldPass.value.clear();
    newPass.value.clear();
  }



}