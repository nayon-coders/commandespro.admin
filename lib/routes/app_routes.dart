import 'package:commandespro_admin/data/binding/app_setting_binding.dart';
import 'package:commandespro_admin/data/binding/category_binding.dart';
import 'package:commandespro_admin/data/binding/invoice_genarate_binding.dart';
import 'package:commandespro_admin/data/binding/order_binding.dart';
import 'package:commandespro_admin/data/binding/post_code_binding.dart';
import 'package:commandespro_admin/features/ajouter_cmd/screen/add_customer.dart';
import 'package:commandespro_admin/features/ajouter_cmd/screen/add_cmd.dart';
import 'package:commandespro_admin/features/app_screen/screen/app_setting.dart';
import 'package:commandespro_admin/features/customers_screen/screen/customer_screen.dart';
import 'package:commandespro_admin/features/dashboard/screens/dashboard.dart';
import 'package:commandespro_admin/features/invoice/screen/invoice_genaret.dart';
import 'package:commandespro_admin/features/order/screen/edit_order.dart';
import 'package:commandespro_admin/features/order/screen/order_invoice.dart';
import 'package:commandespro_admin/features/order/screen/order_list.dart';
import 'package:commandespro_admin/features/products/screens/add_products.dart';
import 'package:commandespro_admin/features/settings/screen/add_new_user.dart';
import 'package:commandespro_admin/features/settings/screen/edit_user.dart';
import 'package:commandespro_admin/features/settings/screen/post_code.dart';
import 'package:commandespro_admin/features/settings/screen/user_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/binding/admin_binding.dart';
import '../data/binding/auth_binding.dart';
import '../data/binding/client_binding.dart';
import '../data/binding/product_binding.dart';
import '../data/binding/user_binding.dart';
import '../features/app_screen/screen/app_page.dart';
import '../features/auth/screen/auth_view.dart';
import '../features/cradit/screen/cradit.dart';
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
        page: ()=>AddNewAdmin(),
        binding: AdminBinding()
    ),
    GetPage(
        name: AppRoute.edit_new_user,
        transition:Transition.fade ,
        page: ()=>EditUser(),
        binding: AdminBinding()
    ),
    GetPage(
      name: AppRoute.admin_list,
      transition:Transition.fade ,
      page: ()=>AdminList(),
      binding: AdminBinding()
    ),


    //app setting
    GetPage(
        name: AppRoute.setting,
        transition:Transition.fade ,
        binding: AppSettingBinding(),
        page: ()=>AppSetting(),

    ),
    GetPage(
      name: AppRoute.pages,
      transition:Transition.fade ,
      page: ()=>AppPage(),
      binding: AppSettingBinding(),

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
      page: ()=>AddCustomer(),
      binding: ClientBinding()
    ),

    GetPage(
      name: AppRoute.customers,
      transition: Transition.fade,
      page: ()=>CustomerScreen(),
      binding: UserBinding()
    ),

    GetPage(
      name: AppRoute.orders,
      transition: Transition.fade,
      page: ()=>OrderListView(),
      binding: OrderBinding()
    ),
    GetPage(
        name: AppRoute.edit_order,
        transition: Transition.fade,
        page: ()=>EditOrder(),
        binding: OrderBinding()
    ),
    GetPage(
      name: AppRoute.postal_code,
      transition: Transition.fade,
      page: ()=>PostCode(),
      binding: PostCodeBinding()
    ),

    GetPage(
        name: AppRoute.order_invoice,
        transition: Transition.fade,
        page: ()=>OrderInvoice(),
        binding: PostCodeBinding()
    ),
    GetPage(
        name: AppRoute.invoice_genaret,
        transition: Transition.fade,
        page: ()=>InvoiceGanerate(),
        binding: InvoiceGenarateBinding()
    ),
    GetPage(
        name: AppRoute.credit,
        transition: Transition.fade,
        page: ()=>CraditScreen(),
    ),
  ];
}