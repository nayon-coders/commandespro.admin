import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/settings/controller/admin.role.controller.dart';
import 'package:commandespro_admin/features/settings/widgets/role_dorpdown.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../comman/app_input.dart';
import '../../../comman/dropdown2.dart';
import '../../../controller/product_json.dart';
import '../../../utility/text_style.dart';

class AddNewAdmin extends StatefulWidget {
   AddNewAdmin({super.key});

  @override
  State<AddNewAdmin> createState() => _AddNewAdminState();
}

class _AddNewAdminState extends State<AddNewAdmin> {
  final _email = TextEditingController();

  final _password = TextEditingController();

  final _firstName  = TextEditingController();

  final _lastName = TextEditingController();

  String? selectedValue;
  bool isChecked = false;

  final AdminRoleController controller = Get.find<AdminRoleController>();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTab = ResponsiveBreakpoints.of(context).isTablet;
    return AppScaffold(
        body: Container(
          width: Get.width,
          padding: isMobile || isTab ? EdgeInsets.all(15) : EdgeInsets.only(left: 100, right: 100, top: 40, bottom: 50),
          child: Column(
            children: [
              Container(
                padding:const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lighGry,
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
                     Obx(() {
                       if(controller.isEdit.value){
                          return Text("Edit User",style: formTitleStyle(),);
                       }else{
                          return Text("Add User",style: formTitleStyle(),);
                       }
                       }
                     ),
                    const SizedBox(height: 20,),

                    AppInput(hint: "Enter user Email", controller: controller.email.value, text: "Email(Username)*"),
                   const SizedBox(height:20,),

                    AppInput(hint: "Password", controller:  controller.pass.value, text: "Password*"),
                    const SizedBox(height:20,),

                    AppInput(hint: "User's First Name", controller:  controller.firstName.value, text: "First Name*"),
                    const SizedBox(height:15,),

                    AppInput(hint: "User's Last Name", controller:  controller.lastName.value, text: "Last Name*"),
                    const SizedBox(height:20,),

                    const Text("Role",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                   const SizedBox(height: 10,),
                    AdminRoleList(),



                    Obx((){
                        return AppButton(
                          isLoading: controller.isCreatingAdmin.value,
                          onClick: (){
                            controller.createNewAdmin();
                          },
                          text: "Add User",
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
    );
  }
}
