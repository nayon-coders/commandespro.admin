import 'dart:convert';
import 'dart:html' as html;
import 'package:commandespro_admin/data/json/menus_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app.config.dart';
import '../../../data/model/admin_profile_model.dart';
import '../../../data/service/api.service.dart';
import '../../../main.dart';
import '../../../routes/app_pages.dart';
class AuthController extends GetxController {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _status = Rx<RxStatus>(RxStatus.empty());

  RxBool isShow = true.obs;
  RxBool login = true.obs;
  RxBool isLoading = false.obs;
  RxBool valuefirst = true.obs;

  RxStatus get status => _status.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


  bool _isValid() {
    if (nameController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  void checkBoxValue(value){
    valuefirst.value = value!;
  }

  Rx<AdminProfileModel> myprofiel = AdminProfileModel().obs;


  //login with api
  Future adminLogin(String email, String pass)async{
    isLoading.value = true;
    var response = await http.post(Uri.parse(AppConfig.LOGIN,),
        body: jsonEncode(
            {
              "email": email,
              "password": pass
            }
        ),
        headers: {
          "Content-Type" : "application/json"
        }
    );

    var data = jsonDecode(response.body);

    if(response.statusCode == 200){

      html.window.localStorage["token"] = data["data"]["token"].toString();
    sharedPreferences?.setString("token", data["data"]["token"].toString());

      await getMyProfile();
      if(sharedPreferences!.getString("role") != null){
        print("account role it ---- ${sharedPreferences!.getString("role")}");

        Get.snackbar("Login Success!", "Welcome to Admin Panel");
        Get.toNamed(AppRoute.dashboard);
      }

    }else{
      Get.snackbar("Login Failed", "${data["error"]}");
    }
    isLoading.value = false;
  }


  //get my profile
  RxBool isGettingMyProfile = false.obs;
  Future getMyProfile()async{
    isGettingMyProfile.value = true;
    var response = await ApiService().getApi(AppConfig.MY_PROFILE);

    var data = jsonDecode(response.body);

    if(response.statusCode == 200){
      sharedPreferences!.setString("role", data["role_name"]);
      AppMenus.getMenuForRole(data["role_name"]);
      myprofiel.value = AdminProfileModel.fromJson(data);
    }
    isGettingMyProfile.value = false;

    return isGettingMyProfile.value;
  }
}