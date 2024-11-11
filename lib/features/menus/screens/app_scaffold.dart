import 'package:commandespro_admin/data/json/menus_list.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:commandespro_admin/utility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:hover_menu/hover_menu.dart';
import 'package:get/get.dart';
import 'package:hover_menu/hover_menu_controller.dart';

import '../../menus/screens/app_footer.dart';
import '../../menus/screens/menus.dart';
import '../../menus/screens/top_bar.dart';
class AppScaffold extends StatefulWidget {
  final Widget body;
  const AppScaffold({super.key, required this.body});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  HoverMenuController? hoverMenuController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: ListView(

          children: [
            //top bar
            TopbarWidgets(), //top bar
            //menu
            AppMenuBar(), //menu

            widget.body, //body





            //footer
            AppFooter()
          ],
        ),
      ),

    );
  }
}



