import 'package:commandespro_admin/data/model/all_delivery_address_model.dart';
import 'package:commandespro_admin/features/ajouter_cmd/widget/add_delivery_address_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../data/model/user.list.model.dart';
import '../../../routes/app_pages.dart';
import '../../../utility/app_const.dart';
import '../../customers_screen/controller/user.controller.dart';
import '../controller/controller.dart';

class SelectDeliveryAddress extends StatelessWidget {
  const SelectDeliveryAddress({
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
    return Obx(() {
        return Visibility(
          visible: customerController.selectedUser.value.id != null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Select Delivery Address",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),),
                  TextButton(
                    onPressed: (){
                      if(controller.selectedUser.value.id != null) {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AddDeliveryAddressView();
                            });
                      }else{
                        Get.snackbar("Error", "Please select a customer first", backgroundColor: Colors.red, colorText: Colors.white);
                      }

                    },
                    child:   Text("Add address",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                  )
                ],
              ),
            controller.isAddressGetting.value
                ?  Container(
              width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ) :  controller.allDeliveryAddress.value.data == null ? Container(
              width: Get.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text("No delivery address found"),
              ),
            ) :Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<DeliveryAddressModel>(
                    isExpanded: true,
                    hint: Text(
                      'Select Delivery Address',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: controller.allDeliveryAddress.value.data!.map((item) {
                      return DropdownMenuItem<DeliveryAddressModel>(
                        value: item,
                        child: Text(
                          "${item.address}, ${item.postCode}, ${item.city}" ?? '', // Add null safety check here
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    value: controller.selectedDeliveryAddress.value, // Ensure a valid value is selected
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedDeliveryAddress.value = value;
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
              )

            ],
          ),
        );
      }
    );
  }
}
