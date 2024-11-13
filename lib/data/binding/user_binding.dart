import 'package:get/get.dart';

import '../../features/settings/controller/user.controller.dart';
class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppUserController>(() => AppUserController());
  }
}