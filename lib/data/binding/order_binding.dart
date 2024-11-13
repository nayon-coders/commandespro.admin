import 'package:get/get.dart';

import '../../features/ajouter_cmd/controller/controller.dart';
import '../../features/order/controller/order_ontroller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}