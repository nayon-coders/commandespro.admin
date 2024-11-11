// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool selected = true.obs;
  RxBool isShowen = true.obs;

  // void changeLanguage(var param1, var param2) {
  //   var locale = Locale(param1, param2);
  //   Get.updateLocale(locale);
  // }
}

class HomeController extends GetxController {
  DateTimeRange? selectedDateRange;

  var dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 6,
    ),
  ).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // full screen
  // chooseDateRangePicker(context, builder) async {
  //   DateTimeRange? picked = await showDateRangePicker(
  //       context: Get.context!,
  //       firstDate: DateTime(DateTime.now().year - 20),
  //       lastDate: DateTime(DateTime.now().year + 20),
  //       initialDateRange: dateRange.value);
  //   if (picked != null && picked != dateRange.value) dateRange.value = picked;
  // }

  // DateTimeRange initialDateRange = DateTimeRange(
  //   start: DateTime.now(), // Set the initial start date
  //   end: DateTime.now().add(const Duration(days: 7)), // Set the initial end date
  // );
}
