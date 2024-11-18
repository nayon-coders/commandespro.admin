import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerController extends GetxController {
  // Reactive date variable initialized to the current date
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxString get formattedDate => DateFormat("MM/dd/yyyy").format(selectedDate.value).obs;
  RxString get formattedDateForServer => DateFormat("yyyy-MM-dd").format(selectedDate.value).obs;

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
