
import 'package:commandespro_admin/features/products/controller/category.controller.dart';
import 'package:get/get.dart';

import '../../features/products/controller/postcode.controller.dart';
import '../../features/products/controller/product_controller.dart';


class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<CategoryController>(()=>CategoryController());
  }



}