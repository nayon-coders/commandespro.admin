import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // RxList<String> users = RxList<String>([]);
  static UserController get to => Get.put(UserController());
  var textEditingController = TextEditingController();
  var values = <String>[].obs;

  void onTextChanged(String value) {
    textEditingController.text = value;
  }

  void addValue() {
    values.add(textEditingController.text);
    textEditingController.text = '';
  }

  void editValue(int index, String value) {
    textEditingController.text = value;
    values.removeAt(index);
  }
}

