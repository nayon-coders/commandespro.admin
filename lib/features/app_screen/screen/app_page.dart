import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/AppButton.dart';
import '../../../comman/app_input.dart';

class AppPage extends StatelessWidget {
   AppPage({super.key});

  final _privacyPolicy = TextEditingController();
  final _termsCondition = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body:Container(
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

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width*0.40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20,),

                          AppInput(
                              hint: "Privacy Policy",
                              controller:_privacyPolicy,
                              text: "Privacy Policy *",
                            maxLine: 15,
                          ),
                          const SizedBox(height:20,),



                          AppButton(
                            onClick: (){},
                            text: "Save",

                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width*0.40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20,),

                          AppInput(
                              hint: "Terms Condition",
                              controller:  _termsCondition,
                              text: "Terms Condition *",
                            maxLine: 15,
                          ),
                          const SizedBox(height:20,),
                          AppButton(
                            onClick: (){},
                            text: "Save",

                          ),

                        ],
                      ),
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
