import 'package:commandespro_admin/data/binding/category_binding.dart';
import 'package:commandespro_admin/features/dashboard/screens/dashboard.dart';
import 'package:commandespro_admin/features/products/screens/add_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/binding/product_binding.dart';
import '../features/products/screens/category.dart';
import '../features/products/screens/product_list.dart';
import 'app_pages.dart';
class AppPages{
  final List<GetPage<dynamic>> route = [
    //getRoute for all the AppPages
    GetPage(
        name: AppRoute.dashboard,
        transition: Transition.fadeIn,
        page: () => Dashboard()
    ),

    GetPage(
        name: AppRoute.product_list,
        transition: Transition.fadeIn,
        page: () => ProductList(),
      binding: ProductBinding()
    ),
    GetPage(
        name: AppRoute.add_new_product,
        transition: Transition.fade,
        page: () => AddProducts(),
        binding: ProductBinding()
    ),
   GetPage(
          name: AppRoute.categories,
          transition: Transition.fade,
          page: () => CategoryScreen(),
          binding: CategoryBinding()
      ),

  ];
}