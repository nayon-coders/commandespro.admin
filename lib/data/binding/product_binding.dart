import 'package:get/get.dart';

import '../../features/products/controller/postcode.controller.dart';
import '../../features/products/controller/product_controller.dart';


class ProductBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<ProductController>(()=>ProductController());
    Get.lazyPut<PostCodeController>(()=>PostCodeController());
  }



}