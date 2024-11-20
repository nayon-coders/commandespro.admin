import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hover_menu/hover_menu.dart';

import '../../../data/json/menus_list.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';
import '../controller/menu_controller.dart';

class AppMenuBar extends StatelessWidget {
   AppMenuBar({
    super.key,
  });

  final AppMenuController controller = Get.find();



   @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth > 800){
            return WebMenuView(controller: controller);
          }else{
            //small device
            return MobileMenuView();
          }

        }
    );
  }
}

class MobileMenuView extends StatelessWidget {
   MobileMenuView({
    super.key,
  });

  final AppMenuController controller = Get.find();



  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      padding: const EdgeInsets.only(left: AppPadding.defaultPadding, right: AppPadding.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white, size: 30,)),
          IconButton(
              onPressed: (){
                Get.toNamed(AppRoute.profile);

              },
              icon: Icon(Icons.person, color: Colors.white, size: 30,)),
        ],
      ),
    );
  }
}

class WebMenuView extends StatelessWidget {
  const WebMenuView({
    super.key,
    required this.controller,
  });

  final AppMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      padding: const EdgeInsets.only(left: AppPadding.defaultPadding, right: AppPadding.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left side  menus
          SizedBox(
            width: Get.width * .60,
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppMenus.menus.length,
              itemBuilder: (_, index){
                return Obx((){
                  //------
                  // main type menu
                  return HoverMenu(
                    width: 350,
                    title: InkWell(
                      onHover: (isHovered) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          // controller.selectedMenuId.value = -1;
                          controller.onAddCustomerClick.value = false;
                          controller.onAddCMDClick.value = false;
                          controller.onHoverSubMenuId.value = {};
                          controller.onAddCMDHover.value = false;
                          controller.onAddCustomerHome.value = false;
                        });
                      },
                      onTap: (){
                        controller.selectedMenuId.value = index; //set selected menu id
                        Get.toNamed(AppMenus.menus[index]["page"]!); //navigate to the page
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:  controller.selectedMenuId.value == index ? BorderSide(
                                    color: controller.selectedMenuId.value != index? AppColors.textColor : Colors.white,
                                    width: 2
                                ): BorderSide.none
                            )
                        ),
                        child: Row(
                          children: [
                            Text("${AppMenus.menus[index]["title"]}",
                              style: controller.selectedMenuId.value == index ? selectedMenuTextStyle() : menusTextStyle() ,
                            ),
                            AppMenus.menus[index]["items"]!.isNotEmpty ? Icon(Icons.keyboard_arrow_down_outlined, color: controller.selectedMenuId.value == index  ? Colors.black :Colors.white,) : Center(),
                          ],
                        ),
                      ),
                    ),

                    //sub menu
                    items: AppMenus.menus[index]["items"]!.isNotEmpty
                        ? AppMenus.menus[index]["items"].map<Widget>((item) {
                      return InkWell(
                        onHover: (isHovered) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.selectedMenuId.value = -1;
                            controller.onAddCMDHover.value = false;
                            controller.onAddCustomerClick.value = false;
                            controller.onAddCMDClick.value = false;
                            controller.onAddCustomerHome.value = false;
                            // Set the hover state based on the item's "title" property or any other unique identifier
                            controller.onHoverSubMenuId.value = isHovered ? item : null;
                          });
                        },
                        onTap: () {
                          // Handle item tap, such as selecting the main menu ID
                          controller.selectedMenuId.value = index;
                          Get.toNamed(item["page"]!); //navigate to the page
                        },
                        child: Obx(() => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.onHoverSubMenuId.value["title"] == item["title"]
                                ? Colors.grey.shade200 // Hover color
                                : Colors.white, // Default color
                          ),
                          child: controller.onHoverSubMenuId.value["title"] != item["title"]
                              ? Text(
                            "${item["title"]}", // Access the "title" property from the item map
                            style: TextStyle(
                              color: AppColors.primaryColor, // This color will be replaced by the gradient
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )
                              : ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.green,
                              ],
                              //  tileMode: TileMode.repeated,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "${item["title"]}", // Access the "title" property from the item map
                                style: TextStyle(
                                  color: Colors.white, // This color will be replaced by the gradient
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )),
                      );
                    }).toList()
                        : [],

                  );
                }
                );
              },

            ),
          ),




          //right side button
          Obx(() {
            return Row( //right side button
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
                SizedBox(width: 30,),
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
          )

        ],
      ),

    );
  }
}
