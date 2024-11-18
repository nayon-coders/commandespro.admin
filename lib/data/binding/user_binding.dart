import 'package:get/get.dart';

import '../../features/customers_screen/controller/user.controller.dart';
import '../../features/settings/controller/admin.role.controller.dart';
class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppUserController>(() => AppUserController());
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());

  }
}