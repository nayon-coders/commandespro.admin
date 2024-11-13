import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/settings/controller/admin.role.controller.dart';
import 'package:commandespro_admin/features/settings/widgets/role_dorpdown.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_input.dart';
import '../../../comman/dropdown2.dart';
import '../../../controller/product_json.dart';
import '../../../utility/text_style.dart';

class EditUser extends StatefulWidget {
  EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _email = TextEditingController();

  final _password = TextEditingController();

  final _firstName  = TextEditingController();

  final _lastName = TextEditingController();

  String? selectedValue;
  bool isChecked = false;

  final AdminRoleController controller = Get.find<AdminRoleController>();

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
                  Text("Edit User",style: formTitleStyle(),),
                  const SizedBox(height: 20,),

                  AppInput(hint: "Enter user Email", controller: controller.email.value, text: "Email(Username)*"),
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
                      isLoading: controller.isUpdatingAdmin.value,
                      onClick: (){
                        controller.updateAdmin(controller.selectedId.value);

                      },
                      text: "Edit User",
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
