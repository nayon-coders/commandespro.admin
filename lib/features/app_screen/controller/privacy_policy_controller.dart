import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:commandespro_admin/app.config.dart';
import 'package:commandespro_admin/data/model/privacy_model.dart';
import 'package:commandespro_admin/data/service/api.service.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController{

  Rx<PrivacyModel> privacyModel = PrivacyModel().obs;

  Rx<TextEditingController> privacyPolicy = TextEditingController().obs;
  Rx<TextEditingController> termsCondition = TextEditingController().obs;
  Rx<TextEditingController> aboutUs = TextEditingController().obs;
  Rx<TextEditingController> legal = TextEditingController().obs;

  RxBool isGetting = false.obs;
  RxBool isUpdating = false.obs;

  @override
  onInit(){
    super.onInit();
    getPrivacy();

  }


  //get privacy policy
  getPrivacy()async{
    isGetting.value = true;

    final res = await ApiService().getApi(AppConfig.PRIVACY_GET);
    if(res.statusCode == 200){
      print("Success: ${jsonDecode(res.body)["message"]}");
      privacyModel.value = PrivacyModel.fromJson(json.decode(res.body));

      //get value textField
      privacyPolicy.value.text = privacyModel.value.data!.privacy ?? "";
      termsCondition.value.text = privacyModel.value.data!.terms ?? "";
      aboutUs.value.text = privacyModel.value.data!.aboutUs ?? "";
      legal.value.text = privacyModel.value.data!.legal ?? "";
    }else{
      print("Failed ${jsonDecode(res.body)["message"]}");
    }
    isGetting.value = false;
  }
  
  upDatePrivacy()async{
    isUpdating.value = true;

    final data ={
      "privacy":privacyPolicy.value.text,
      "terms":termsCondition.value.text,
      "about_us":aboutUs.value.text,
      "legal":legal.value.text,
    };
    final res = await ApiService().putApi(AppConfig.PRIVACY_UPDATE, data);

    if(res.statusCode == 200){
      Get.snackbar("Success", "PrivacyPolicy Update",backgroundColor: Colors.green,colorText: Colors.white);
    }else{
      Get.snackbar("Failed", "${jsonDecode(res.body)["message"]}",backgroundColor: Colors.red);
    }
    isUpdating.value = false;
    
  }
  
  
}