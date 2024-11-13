import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/admin.role.list.model.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';
import '../controller/admin.role.controller.dart';

class AdminRoleList extends GetView<AdminRoleController> {
  const AdminRoleList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllRoleList();
    });
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<SingleAdminRole>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: controller.adminRoleListModel.value.data!.map((item) {
                return DropdownMenuItem<SingleAdminRole>(
                  value: item,
                  child: Text(
                    item.roleName!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              value: controller.selectedSingleAdminRole.value,
              onChanged: (value) {
                print("selected value: $value");
                // Check if the value is not null before assigning
                if (value != null) {
                  controller.selectedSingleAdminRole.value = value;
                  for(int i = 0; i < controller.selectedSingleAdminRole.value.permissions!.length; i++) {
                    controller.isSelected.add(true);
                  }
                }
              },
              buttonStyleData:  ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  )
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),

          const SizedBox(height: 30,),

          const Text("Access Rights",style:TextStyle(color: AppColors.primaryColor,fontSize: 16,fontWeight: FontWeight.bold)),
          const SizedBox(height: 10,),
          Padding(
            padding:  EdgeInsets.only(left: 20.0),
            child: Obx((){
                return ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.selectedSingleAdminRole.value.permissions!.length,
                    itemBuilder: (context, index) {
                      var data = controller.selectedSingleAdminRole.value.permissions![index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data.section}:",style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor
                          ),),
                          SizedBox(height: 10,),
                          ListView.builder(
                            itemCount: data.name!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, sectionItems) {
                              var sectionName = controller.selectedSingleAdminRole.value.permissions![index].name![sectionItems];
                              return Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(() {
                                      return Checkbox(
                                        value: controller.isSelected[sectionItems] ?? false, // Provide a default value if the key doesn't exist
                                        onChanged: (value) {
                                          print("value: $value");
                                          if(controller.selectedSingleAdminRole.value.permissions![index].name![sectionItems] == sectionName) {
                                            controller.isSelected.insert(sectionItems, value!);
                                          }

                                        },
                                      );
                                    }),

                                    Text("${sectionName}",style: pTextStyle(),),
                                  ],
                                ),
                              );
                            }
                          ),
                        ],
                      );
                    }
                );
              }
            ),
          ),
          const SizedBox(height: 25,),
        ],
      );
    }
    );

  }
}
