import 'package:commandespro_admin/data/json/menus_list.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:commandespro_admin/utility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:hover_menu/hover_menu.dart';
import 'package:get/get.dart';
import 'package:hover_menu/hover_menu_controller.dart';
import 'package:intl/intl.dart';

import '../../menus/screens/app_footer.dart';
import '../../menus/screens/menus.dart';
import '../../menus/screens/top_bar.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HoverMenuController? hoverMenuController;

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      body: Container(
        padding: EdgeInsets.all(AppPadding.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            //Today Date
            Center(
              child: Container(
                padding: EdgeInsets.all(40),
                child: Text("${DateFormat('EEEE, d MMMM y').format(DateTime.now()).toString()}", style: h2TextStyle(),),
              ),
            ),
        
            Center(
              child: Text("Orders",
                style: h1TextStyle(),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: Colors.green,
                          width: 5
                        )
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Today",
                          style: h1TextStyle(),
                        ),
                        SizedBox(height: 10,),
                        Text("€1,487.50 excl. tax",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: AppColors.primaryColor
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(height: 1, color: Colors.grey.shade200,),
                        SizedBox(height: 10,),
                        Text("Previous Day: €1,487.50 excl. tax",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.textColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Current Week: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Current Month: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(
                              color: Colors.green,
                              width: 5
                          )
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Today",
                          style: h1TextStyle(),
                        ),
                        SizedBox(height: 10,),
                        Text("€1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35,
                              color: AppColors.primaryColor
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(height: 1, color: Colors.grey.shade200,),
                        SizedBox(height: 10,),
                        Text("Previous Day: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Current Week: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Current Month: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        )
                      ],
                    ),
                  ),
                )
                
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(
                              color: Colors.green,
                              width: 5
                          )
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Today",
                          style: h1TextStyle(),
                        ),
                        SizedBox(height: 10,),
                        Text("€1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35,
                              color: AppColors.primaryColor
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(height: 1, color: Colors.grey.shade200,),
                        SizedBox(height: 10,),
                        Text("Previous Day: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Current Week: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Current Month: €1,487.50 excl. tax",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.textColor
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Center(),
                )

              ],
            ),
        
          ],
        ),
      ),
    );
  }
}



