import 'package:get/get.dart';

import '../../features/products/controller/postcode.controller.dart';
import '../../features/products/controller/product_controller.dart';
import '../../features/settings/controller/admin.role.controller.dart';


class PostCodeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<PostCodeController>(()=>PostCodeController());
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());

  }



}