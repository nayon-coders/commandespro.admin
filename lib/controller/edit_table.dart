import 'package:get/get.dart';

class EditController extends GetxController {
  RxBool isEdit = false.obs;

  var valueFirst = false.obs;

  void toggleCheckbox(bool value) {
    valueFirst.value = value;
  }
}
