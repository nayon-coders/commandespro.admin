import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../data/model/product.list.model.dart';
import '../../../routes/app_pages.dart';
import '../../../utility/app_const.dart';
import '../../products/controller/product_controller.dart';
import '../controller/controller.dart';

class SelectProduct extends StatelessWidget {
  const SelectProduct({
    super.key,
    required this.productController,
    required this.controller,
  });

  final ProductController productController;
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
          visible: controller.selectedUser.value != null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Select Product",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),),
                  // TextButton(
                  //   onPressed: ()=>Get.toNamed(AppRoute.add_new_product),
                  //   child:  const Text("Add new product",
                  //     style: TextStyle(
                  //       color: AppColors.primaryColor,
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Obx(() {
                if (productController.isGettingData.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // Check if data is null or empty
                  final productData = productController.productListModel.value.data;
                  if (productData == null || productData.isEmpty) {
                    return Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    );
                  }

                  return Container(
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<SingleProducts>(
                        isExpanded: true,
                        hint: Text(
                          'Select Product',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: productData.map((item) {
                          return DropdownMenuItem<SingleProducts>(
                            value: item,
                            child: Text(
                              item.name ?? 'Unnamed Product', // Provide a fallback text
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        value: controller.selectedProduct.value, // Remove redundant `?? null`
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedProduct.value = value;
                            controller.selectedProductList.add(value);
                            controller.comment.add(TextEditingController());
                            controller.quantity.add(TextEditingController(text: "1"));

                            controller.totalPriceCalculation(
                              controller.selectedProductList.length - 1,
                            );
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
          ),
        );
      }
    );
  }
}
