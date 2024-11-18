import 'package:commandespro_admin/features/customers_screen/controller/user.controller.dart';
import 'package:commandespro_admin/features/invoice/controller/controller.dart';
import 'package:get/get.dart';

import '../../features/settings/controller/admin.role.controller.dart';

class InvoiceGenarateBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<InvoiceController>(()=>InvoiceController());
    Get.lazyPut<AdminRoleController>(() => AdminRoleController());

    Get.lazyPut<AppUserController>(()=>AppUserController());
  }



}