import 'package:get/get.dart';

import '../../features/ajouter_cmd/controller/controller.dart';
import '../../features/ajouter_cmd/controller/customer_controller.dart';
import '../../features/settings/controller/admin.role.controller.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CMDController());
    Get.lazyPut(() => CustomerController());
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());

  }
}