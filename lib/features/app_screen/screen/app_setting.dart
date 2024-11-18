import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/AppButton.dart';
import '../../../comman/app_input.dart';

class AppSetting extends StatelessWidget {
   AppSetting({super.key});
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Container(
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

                    AppInput(hint: "Current Password", controller:_oldPassword, text: "Current Password*"),
                    const SizedBox(height:20,),

                    AppInput(hint: "New Password", controller:  _newPassword, text: "New Password*"),
                    const SizedBox(height:20,),


                       AppButton(
                        onClick: (){},
                        text: "Save",
                        width: double.infinity,
                      ),

                  ],
                ),
              ),



            ],
          ),
        ),
    );
  }
}
