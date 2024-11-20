import 'package:commandespro_admin/features/app_screen/controller/privacy_policy_controller.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../comman/AppButton.dart';
import '../../../comman/app_input.dart';

class AppPage extends GetView<PrivacyPolicyController> {
   const AppPage({super.key});


  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTab = ResponsiveBreakpoints.of(context).isTablet;
    double fontSize = 16;
    if(isMobile || isTab){
      fontSize = 13;
    }else{
      fontSize = 16;
    }
    return AppScaffold(
        body:Container(
          width: Get.width,
          padding: isMobile || isTab ? EdgeInsets.all(15) : EdgeInsets.only(left: 100, right: 100, top: 40, bottom: 50),
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

                child: Obx(() {
                  if(controller.isGetting.value){
                    return const Center(child: CircularProgressIndicator.adaptive(),);
                  }else{
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            //Privacy Policy
                            SizedBox(
                              width: Get.width*0.40,
                              child: AppInput(
                                hint: "Privacy Policy",
                                controller:controller.privacyPolicy.value,
                                text: "Privacy Policy *",
                                maxLine: 15,
                              ),
                            ),

                            //terms Condition
                            SizedBox(
                              width: Get.width*0.40,
                              child: AppInput(
                                hint: "Terms Condition",
                                controller:  controller.termsCondition.value,
                                text: "Terms Condition *",
                                maxLine: 15,
                              ),
                            ),
                          ],
                        ),

                       const SizedBox(height: 40,),

                        //AboutUs & Legal
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            //About us
                            SizedBox(
                              width: Get.width*0.40,
                              child: AppInput(
                                hint: "About Us",
                                controller:controller.aboutUs.value,
                                text: "About Us *",
                                maxLine: 15,
                              ),
                            ),

                            //Legal
                            SizedBox(
                              width: Get.width*0.40,
                              child: AppInput(
                                hint: "Legal",
                                controller:  controller.legal.value,
                                text: "Legal *",
                                maxLine: 15,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40,),
                        AppButton(
                          width: Get.width,
                          isLoading: controller.isUpdating.value,
                          onClick: (){
                            controller.upDatePrivacy();
                          },
                          text: "Save",

                        ),
                      ],
                    );
                  }

                  }
                ),
              ),


            ],
          ),
        ),
    );
  }
}
