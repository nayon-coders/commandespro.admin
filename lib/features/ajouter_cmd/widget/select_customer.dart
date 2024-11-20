import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../data/model/user.list.model.dart';
import '../../../routes/app_pages.dart';
import '../../../utility/app_const.dart';
import '../../customers_screen/controller/user.controller.dart';
import '../controller/controller.dart';

class SelectCustomer extends StatelessWidget {
  const SelectCustomer({
    super.key,
    required this.customerController,
    required this.controller,
  });

  final AppUserController customerController;
  final CMDController controller;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("Select Customer",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),),
            TextButton(
              onPressed: ()=>Get.toNamed(AppRoute.addClient),
              child:   Text("Add new customer",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                ),
              ),
            )
          ],
        ),
        Obx(() {
          if(customerController.isLoading.value){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Container(
              width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<UserList>(
                  isExpanded: true,
                  hint: Text(
                    'Select Customer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: customerController.userListModel.value.data!.map((item) {
                    return DropdownMenuItem<UserList>(
                      value: item,
                      child: Text(
                        item.name ?? '', // Add null safety check here
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                  value: customerController.selectedUser.value, // Ensure a valid value is selected
                  onChanged: (value) {
                    if (value != null) {
                      print("Selected User: ${value.id}");
                      //
                      customerController.selectedUser.value = value;
                      controller.selectedUser.value = value;
                      controller.selectedCustomerName.value = value.name!;
                      //get all delivery address by id
                      controller.getAllDeliveryAddress();
                    }
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 50,
                  ),
                ),
              ),
            );
          }

        }),
      ],
    );
  }
}
