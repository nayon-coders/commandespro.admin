import 'package:commandespro_admin/features/settings/controller/admin.role.controller.dart';
import 'package:get/get.dart';

import '../../features/settings/controller/user.controller.dart';
class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());
  }
}