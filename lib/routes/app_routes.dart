import 'package:commandespro_admin/data/binding/category_binding.dart';
import 'package:commandespro_admin/data/binding/order_binding.dart';
import 'package:commandespro_admin/features/ajouter_cmd/screen/add_client.dart';
import 'package:commandespro_admin/features/ajouter_cmd/screen/add_cmd.dart';
import 'package:commandespro_admin/features/customers_screen/screen/customer_screen.dart';
import 'package:commandespro_admin/features/dashboard/screens/dashboard.dart';
import 'package:commandespro_admin/features/order/screen/order_list.dart';
import 'package:commandespro_admin/features/products/screens/add_products.dart';
import 'package:commandespro_admin/features/settings/screen/add_new_user.dart';
import 'package:commandespro_admin/features/settings/screen/post_code.dart';
import 'package:commandespro_admin/features/settings/screen/user_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/binding/auth_binding.dart';
import '../data/binding/client_binding.dart';
import '../data/binding/product_binding.dart';
import '../features/auth/screen/auth_view.dart';
import '../features/products/screens/category.dart';
import '../features/products/screens/product_list.dart';
import 'app_pages.dart';
class AppPages{
  final List<GetPage<dynamic>> route = [
    //getRoute for all the AppPages
    GetPage(
        name: AppRoute.login,
        transition: Transition.fadeIn,
        page: () => AuthView(),
      binding: AuthBinding()

    ),
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


    //setting
    GetPage(
        name: AppRoute.add_new_user,
        transition:Transition.fade ,
        page: ()=>AddNewUser(),
    ),
    GetPage(
      name: AppRoute.user_list,
      transition:Transition.fade ,
      page: ()=>UserList(),
    ),
    GetPage(
        name: AppRoute.postal_code,
      transition:Transition.fade ,
      page: ()=>PostCode(),
    ),


    GetPage(
        name: AppRoute.add_cmd,
        transition: Transition.fade,
        page: ()=>AddCmd(),
        binding: ClientBinding()
    ),

    GetPage(
      name: AppRoute.addClient,
      transition: Transition.fade,
      page: ()=>AddClient(),
      binding: ClientBinding()
    ),

    GetPage(
      name: AppRoute.customers,
      transition: Transition.fade,
      page: ()=>CustomerScreen(),
    ),

    GetPage(
      name: AppRoute.orders,
      transition: Transition.fade,
      page: ()=>OrderListView(),
      binding: OrderBinding()
    ),
  ];
}