import 'package:get/get.dart';

import '../../features/ajouter_cmd/controller/controller.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientController());
  }
}