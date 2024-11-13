import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AppMenuController extends GetxController{

  RxInt selectedMenuId = 0.obs; //default menu id
   var onHoverSubMenuId = {}.obs;
   RxBool onAddCMDHover = false.obs;
   RxBool onAddCustomerHome = false.obs;

   RxBool onAddCustomerClick = false.obs;
   RxBool onAddCMDClick = false.obs;


}