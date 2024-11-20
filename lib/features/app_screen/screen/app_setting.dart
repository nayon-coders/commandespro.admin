import 'package:commandespro_admin/features/app_screen/controller/update_password_controller.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/AppButton.dart';
import '../../../comman/app_input.dart';

class AppSetting extends GetView<UpdatePasswordController> {
   AppSetting({super.key});

   final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Form(
          key: _key,
          child: Container(
            width: Get.width,
            padding:const EdgeInsets.only(left: 100, right: 100, top: 40, bottom: 50),
            child: Column(
              children: [
                Container(
                  padding:const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 20,),

                      AppInput(hint: "Current Password", controller:controller.oldPass.value, text: "Current Password*"),
                      const SizedBox(height:20,),

                      AppInput(hint: "New Password", controller:  controller.newPass.value, text: "New Password*"),
                      const SizedBox(height:20,),

                         Obx(() {
                             return AppButton(
                               isLoading: controller.isUpdating.value,
                              onClick: (){
                                 if(_key.currentState!.validate()){
                                   controller.passwordUpdate();
                                 }
                              },
                              text: "Save",
                              width: double.infinity,
                             );
                           }
                         ),

                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
    );
  }
}
