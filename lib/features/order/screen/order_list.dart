import 'package:commandespro_admin/comman/app_table/app.table.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/order/controller/order_ontroller.dart';
import 'package:commandespro_admin/features/order/widgets/order_list_view.dart';
import 'package:commandespro_admin/features/order/widgets/search_orders_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_table/table.header.dart';
class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final OrderController controller = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllOrder();
    });

  }


  final _searchController = TextEditingController();

  bool isSingleOrder = false;
  bool isExporting = false;
  var _selectedOrderId;

  onBack(bool value){
    setState(() {
      isSingleOrder = value;
    });
  }

  onExporting(bool value){
    setState(() {
      isExporting = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body:Container(
          width: Get.width,
          padding:const EdgeInsets.only(left: 130, right: 130, top: 40, bottom: 50),
          child: Column(
            children: [
              Container(
                padding:const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  padding:const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     //   SizedBox(height: 20,),
                        AppTable(
                          //pageLength: controller.allOrderModel.value.totalOrders!,
                          title: "All Order's",
                          headersChildren: [
                            TableHeader(name: "ID", width: 30),
                            TableHeader(name: "CUSTOMER", width: 150),
                            TableHeader(name: "STATUS", width: 200),
                            TableHeader(name: "INVOICE", width: 130),
                            TableHeader(name: "INVOICE DATE", width: 150),
                            TableHeader(name: "TOTAL INCL. VAT	", width: 130),
                            TableHeader(name: "ACTIONS", width: 120),
                            SizedBox(
                              width: 130,
                              child: Row(
                                children: [
                                  TableHeader(name: "SELECTION", width: 90),
                                  Obx(() {
                                    return Checkbox(
                                      value: controller.isAllSelectedOrder.value,
                                      onChanged: (bool? value) {
                                        print("the value  is --- ${value}");
                                        controller.isAllSelectedOrder.value = value!;
                                        if(value){
                                          controller.selectedOrdersItems.value = controller.allOrderModel.value.data!;
                                        }else{
                                          controller.selectedOrdersItems.value = [];
                                        }
                                      },

                                    );
                                  }
                                  ),
                                ],
                              ),
                            ),

                          ],
                          row: Container(
                            height: 500,
                            child: Obx(() {
                              if(controller.isGettingData.value){
                                return Center(child: CircularProgressIndicator(),);
                              }else if(controller.allOrderModel.value.data != null){
                                //cehck search result is empty or not
                                if(controller.searchResults.isNotEmpty){
                                  return SearchOrdersView(controller: controller);
                                }else{
                                  return OrderList(controller: controller);
                                }
                              }else{
                                return Center(child: Text("No Data Found"));
                              }

                            }
                            ),
                          ) ,
                          onSearch: (){
                          //  controller.searchOrderByCompanyName(_searchController.value.text, controller.totalOrder);
                          },
                          searchController: _searchController,

                        ),
                      ],
                    ),

                  ),
                )
              ),
            ],
          ),
        ),
    );
  }
}
