import 'package:commandespro_admin/features/menus/controller/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/date_picker.dart';
import '../../features/products/controller/postcode.controller.dart';
import '../../features/products/controller/product_controller.dart';


class InitBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<AppMenuController>(()=>AppMenuController());
    Get.lazyPut<DatePickerController>(()=>DatePickerController());
  }



}