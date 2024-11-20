import 'package:commandespro_admin/data/json/menus_list.dart';
import 'package:commandespro_admin/features/menus/controller/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utility/app_const.dart';


// Compare this snippet from lib/view/ProductManagement/widgets/add.sub.category.view.dart:
class AppMenuDrawer extends StatefulWidget {
  const AppMenuDrawer({super.key});

  @override
  State<AppMenuDrawer> createState() => _AppMenuDrawerState();
}

class _AppMenuDrawerState extends State<AppMenuDrawer> {
  final AppMenuController controller = Get.put(AppMenuController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              itemCount: AppMenus.menus.length,
              itemBuilder: (_, index){
                var menu = AppMenus.menus[index];
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(menu['title'],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        trailing: menu["items"]!.isEmpty ? SizedBox(width: 1, height: 1,) : Icon(Icons.arrow_drop_down),
                        onTap: () {
                          if(menu["items"]!.isEmpty){
                            Get.toNamed(menu["page"]);
                          }else{
                            controller.setSubMenu(menu["items"]);
                          }

                        },
                      ),
                      Obx(() {
                          return controller.subMenu.isEmpty
                              ? Center()
                              :  ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:  controller.subMenu.length,
                                itemBuilder: (_, index){
                                  return  controller.subMenu[index]["id"] == menu["id"] ?  Container(
                                    padding: EdgeInsets.only(left: 30),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text( controller.subMenu[index]['title'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      trailing:  controller.subMenu[index]["sub_items"]!.isEmpty ? SizedBox(width: 1, height: 1,) : Icon(Icons.arrow_drop_down),
                                      onTap: () {
                                        if( controller.subMenu[index]["sub_items"]!.isEmpty){
                                          Get.toNamed( controller.subMenu[index]["page"]);
                                        }else{
                                        }

                                      },
                                    ),
                                  ) : Center();
                                },
                             );
                        }
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10,),
          Obx(() {
            return Column( //right side button
              children: [
                InkWell(
                  onHover: (isHovered) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      controller.selectedMenuId.value = -1;
                      controller.onHoverSubMenuId.value = {};
                      controller.onAddCustomerHome.value = false;
                      controller.onAddCMDHover.value = isHovered;
                    });
                  },
                  onTap: (){
                    controller.onAddCustomerClick.value = false;
                    controller.onAddCMDClick.value = true;
                    Get.toNamed(AppRoute.add_cmd);
                  },
                  child: Container(
                    padding:const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    decoration:const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined, color:  controller.onAddCMDHover.value ? Colors.black: AppColors.primaryColor,), //icon
                        Text("AJOUTER UNE CMD", style: TextStyle(color:  controller.onAddCMDHover.value ||  controller.onAddCMDClick.value  ? Colors.black: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),), //text
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                InkWell(
                  onHover: (isHovered) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      controller.selectedMenuId.value = -1;
                      controller.onHoverSubMenuId.value = {};
                      controller.onAddCMDHover.value = false;
                      controller.onAddCustomerHome.value = isHovered;
                    });
                  },
                  onTap: (){
                    controller.onAddCMDClick.value = false;
                    controller.onAddCustomerClick.value = true;
                    Get.toNamed(AppRoute.addClient);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined, color:  controller.onAddCustomerHome.value ? Colors.black: AppColors.primaryColor,), //icon
                        Text("AJUTRE UN CLIENT".tr, style: TextStyle(color:  controller.onAddCustomerHome.value || controller.onAddCustomerClick.value ? Colors.black: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),), //text
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}

