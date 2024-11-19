import 'package:commandespro_admin/features/auth/controller/auth_controller.dart';
import 'package:commandespro_admin/features/menus/controller/menu_controller.dart';
import 'package:get/get.dart';

import '../../features/ajouter_cmd/controller/controller.dart';
import '../../features/settings/controller/admin.role.controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());
    Get.lazyPut<AppMenuController>(() => AppMenuController());

  }
}