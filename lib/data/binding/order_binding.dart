import 'package:get/get.dart';

import '../../features/ajouter_cmd/controller/controller.dart';
import '../../features/order/controller/order_ontroller.dart';
import '../../features/settings/controller/admin.role.controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());

  }
}