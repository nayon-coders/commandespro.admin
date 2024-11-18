import 'package:commandespro_admin/features/settings/controller/admin.role.controller.dart';
import 'package:get/get.dart';

import '../../features/customers_screen/controller/user.controller.dart';
class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());
  }
}