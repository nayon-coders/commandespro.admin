import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.config.dart';
import '../../../data/model/post_code_model.dart';
import '../../../data/service/api.service.dart';

class PostCodeController extends GetxController{

  Rx<PostcodeModel> postCodeModel = PostcodeModel().obs; 
  RxBool isDataGetting = false.obs; 
  RxBool isDataAdding = false.obs;
  RxBool isDataDeleting = false.obs;

  Rx<TextEditingController> postCode = TextEditingController().obs; 
  
  //add post code 
  getAllPostCode()async{
    isDataGetting.value = true;
    var res = await ApiService().getApi(AppConfig.POST_CODE_GET); 
    if(res.statusCode == 200){
      postCodeModel.value = PostcodeModel.fromJson(jsonDecode(res.body));
    }
    isDataGetting.value = false;
  }

  //add
//add post code
  addPostCode()async{
    isDataAdding.value = true;
    var data = {
      "code" : postCode.value.text
    };
    var res = await ApiService().postApi(
      AppConfig.POST_CODER_CREATE, data
    );
    if(res.statusCode == 200){
      getAllPostCode();
      Get.snackbar("Success!", "Post code added", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong: status:${res.statusCode}", backgroundColor: Colors.red);
    }
    isDataAdding.value = false;
  }


  //delete post code
  deletePost(id)async{
    isDataDeleting.value = true;
    var res = await ApiService().deleteApi(AppConfig.POST_CODE_DELETE+"$id");
    if(res.statusCode == 200){
      getAllPostCode();
      Get.snackbar("Success!", "Product deleted success!", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong! Status: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isDataDeleting.value = false;
  }



}