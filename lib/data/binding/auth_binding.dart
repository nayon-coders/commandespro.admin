import 'package:commandespro_admin/features/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../../features/ajouter_cmd/controller/controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}