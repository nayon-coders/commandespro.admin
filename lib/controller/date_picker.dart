import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DatePickerController extends GetxController {
  // Reactive date variable initialized to the current date
  Rx<DateTime> selectedDate = DateTime.now().obs;

  // Function to pick a date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked; // Update the selected date
    }
  }
}
