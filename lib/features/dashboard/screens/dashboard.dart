import 'package:commandespro_admin/controller/dashboard_controller.dart';
import 'package:commandespro_admin/data/json/menus_list.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/order/controller/order_ontroller.dart';
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
import '../controller/dashbaord_controller.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HoverMenuController? hoverMenuController;
  final SalesController controller = Get.put(SalesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllOrder();
    });
  }

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
          return Container(
            padding: isMobile ? EdgeInsets.all(10)  :  EdgeInsets.all(AppPadding.defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Today Date
                Center(
                  child: Container(
                    padding: isMobile ? EdgeInsets.all(10)  : EdgeInsets.all(40),
                    child: Text("${DateFormat('EEEE, d MMMM y').format(DateTime.now()).toString()}", style: h2TextStyle(),),
                  ),
                ),

                Center(
                  child: Text("Orders",
                    style: h1TextStyle(),
                  ),
                ),
                SizedBox(height: 30,),
               Obx(() {
                 if(controller.isGettingData.value) {
                   return const Center(child: CircularProgressIndicator(),);
                 }else{
                   if(isMobile){
                     return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
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
                               Text("€${controller.todayTotalSales.toStringAsFixed(2)} excl. tax",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                     color: AppColors.primaryColor
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Divider(height: 1, color: Colors.grey.shade200,),

                             ],
                           ),
                         ),
                         SizedBox(height: 20,),
                         Container(
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
                               Text("This Weak",
                                 style: h1TextStyle(),
                               ),
                               SizedBox(height: 10,),
                               Text("€${controller.weekTotalSales.toStringAsFixed(2)} excl. tax",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                     color: AppColors.primaryColor
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Divider(height: 1, color: Colors.grey.shade200,),

                             ],
                           ),
                         ),
                         SizedBox(height: 20,),
                         Container(
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
                               Text("This Month",
                                 style: h1TextStyle(),
                               ),
                               SizedBox(height: 10,),
                               Text("€${controller.monthTotalSales.toStringAsFixed(2)} excl. tax",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 25,
                                     color: AppColors.primaryColor
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Divider(height: 1, color: Colors.grey.shade200,),

                             ],
                           ),
                         ),
                       ],
                     );
                   }else{
                     return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
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
                                     Text("€${controller.todayTotalSales.toStringAsFixed(2)} excl. tax",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w600,
                                           fontSize: 35,
                                           color: AppColors.primaryColor
                                       ),
                                     ),
                                     SizedBox(height: 10,),
                                     Divider(height: 1, color: Colors.grey.shade200,),

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
                                     Text("This Weak",
                                       style: h1TextStyle(),
                                     ),
                                     SizedBox(height: 10,),
                                     Text("€${controller.weekTotalSales.toStringAsFixed(2)} excl. tax",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w600,
                                           fontSize: 35,
                                           color: AppColors.primaryColor
                                       ),
                                     ),
                                     SizedBox(height: 10,),
                                     Divider(height: 1, color: Colors.grey.shade200,),

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
                                     Text("This Month",
                                       style: h1TextStyle(),
                                     ),
                                     SizedBox(height: 10,),
                                     Text("€${controller.monthTotalSales.toStringAsFixed(2)} excl. tax",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w600,
                                           fontSize: 35,
                                           color: AppColors.primaryColor
                                       ),
                                     ),
                                     SizedBox(height: 10,),
                                     Divider(height: 1, color: Colors.grey.shade200,),

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
                     );

                   }
                 }

                 }
               )

              ],
            ),
          );
        }
      ),
    );
  }
}



