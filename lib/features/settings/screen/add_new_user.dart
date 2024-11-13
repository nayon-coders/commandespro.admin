import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_input.dart';
import '../../../comman/dropdown2.dart';
import '../../../controller/product_json.dart';
import '../../../utility/text_style.dart';

class AddNewUser extends StatefulWidget {
   AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final _email = TextEditingController();

  final _password = TextEditingController();

  final _firstName  = TextEditingController();

  final _lastName = TextEditingController();

  String? selectedValue;
  bool isChecked = false;

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
                     Text("Add User",style: formTitleStyle(),),
                    const SizedBox(height: 20,),

                    AppInput(hint: "Enter user Email", controller: _email, text: "Email(Username)*"),
                   const SizedBox(height:20,),

                    AppInput(hint: "Password", controller: _password, text: "Password*"),
                    const SizedBox(height:20,),

                    AppInput(hint: "User's First Name", controller: _firstName, text: "First Name*"),
                    const SizedBox(height:15,),

                    AppInput(hint: "User's Last Name", controller: _lastName, text: "Last Name*"),
                    const SizedBox(height:20,),

                    const Text("Role",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                   const SizedBox(height: 10,),
                    DropDown2(
                        items: ProductJson.userRole,
                        value: selectedValue,
                        hint: "Role",
                        onChange: (v){
                          setState(() {
                            selectedValue = v;
                          });
                        }
                    ),

                    const SizedBox(height: 30,),

                    const Text("Access Rights",style:TextStyle(color: AppColors.primaryColor,fontSize: 16,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.check_box,color: Colors.grey.shade300,size: 16,),
                          Text("Full access to all features",style: pTextStyle(),),
                        ],
                      ),
                    ),
                   const SizedBox(height: 25,),

                    AppButton(onClick: (){}, text: "Add User",width: double.infinity,),
                  ],
                ),
              ),



            ],
          ),
        ),
    );
  }
}
