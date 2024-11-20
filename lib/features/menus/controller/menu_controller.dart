import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AppMenuController extends GetxController{
 final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

 void openDrawer() {
  scaffoldKey.currentState?.openDrawer();
 }

  RxInt selectedMenuId = 0.obs; //default menu id
   var onHoverSubMenuId = {}.obs;
   RxBool onAddCMDHover = false.obs;
   RxBool onAddCustomerHome = false.obs;

   RxBool onAddCustomerClick = false.obs;
   RxBool onAddCMDClick = false.obs;

   RxList subMenu = [].obs;
   //set sub menu for mobile
   setSubMenu(element){
    subMenu.value = element;
    update();
   }

   resetSubMenu(){
     subMenu.value = [];
     update();
   }


}