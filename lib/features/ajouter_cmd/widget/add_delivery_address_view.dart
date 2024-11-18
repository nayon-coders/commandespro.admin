import 'package:commandespro_admin/comman/app_input.dart';
import 'package:commandespro_admin/features/ajouter_cmd/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/AppButton.dart';
class AddDeliveryAddressView extends StatelessWidget {
  const AddDeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final CMDController controller = Get.find();
    return AlertDialog(
      title: Text('Add New Address'),
      content: Container(
        width: 400,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              AppInput(
                  hint: "Phone Number",
                  controller: controller.deliveryPhoneController.value, text: "Phone Number",
              ),
              SizedBox(height: 20,),
              AppInput(
                hint: "Contact Name",
                controller: controller.deliveryContactController.value, text: "Contact name",
              ),
              SizedBox(height: 20,),
              AppInput(
                hint: "City",
                controller: controller.deliveryCityController.value, text: "City",
              ),
              SizedBox(height: 20,),
              AppInput(
                hint: "Post Code",
                controller: controller.deliveryPostCodeController.value, text: "Post Code",
              ),
              SizedBox(height: 20,),
              AppInput(
                hint: "Address",
                maxLine: 2,
                controller: controller.deliveryAddressController.value, text: "Address",
              ),
              SizedBox(height: 30,),
              Obx((){
                return AppButton(
                  isLoading: controller.isAddressCreating.value,
                  width: 200,
                  text: "Add Delivery Address",
                  onClick: (){
                    controller.createAddress();
                  },
                );
              })

            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
