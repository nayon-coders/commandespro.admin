import 'package:commandespro_admin/comman/app_input.dart';
import 'package:commandespro_admin/features/ajouter_cmd/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressView extends StatefulWidget {
  const ShippingAddressView({super.key});

  @override
  State<ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<ShippingAddressView> {
  final CustomerController controller = Get.find<CustomerController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppInput(
                controller: controller.shippingPhone.value,
                hint: "Contact Phone Number",
                text: "Contact Phone Number",
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: AppInput(
                controller: controller.shippingEmail.value,
                hint: "Contact Email Number",
                text: "Contact Email Number",
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              child: AppInput(
                controller: controller.shippingCity.value,
                hint: "City",
                text: "City",
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: AppInput(
                controller: controller.shippingPostCode.value,
                hint: "Post Code",
                text: "Post Code",
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        AppInput(
          controller: controller.shippingAddress.value,
          hint: "Address",
          text: "Address",
          maxLine: 2,
        ),
        SizedBox(height: 20,),
        AppInput(
          controller: controller.shippingMessage.value,
          hint: "Message",
          text: "Message",
          maxLine: 5,
        ),

      ],
    );
  }
}
