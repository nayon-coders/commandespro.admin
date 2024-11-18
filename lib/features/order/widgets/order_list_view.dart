import 'package:commandespro_admin/comman/app_input.dart';
import 'package:commandespro_admin/comman/dropdown2.dart';
import 'package:commandespro_admin/controller/date_picker.dart';
import 'package:commandespro_admin/controller/product_json.dart';
import 'package:commandespro_admin/features/order/controller/order_ontroller.dart';
import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:commandespro_admin/routes/open_ne_tab_rout.dart';
import 'package:easy_tooltip/easy_tooltip.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_table/table.header.dart';
import '../../../data/model/all_order_model.dart';

class OrderList extends StatelessWidget {
  final OrderController controller;

  final List<OrderItem>? allOrders;
   OrderList({super.key, required this.controller, required this.allOrders});

  final TextEditingController _textEditingController = TextEditingController();

  final DatePickerController datePickerController = Get.put(DatePickerController());

  // List of possible dropdown values
  final List<String> statusValues = [
    "En Attente",
    "Préparation",
    "Dispatch",
    "Livraison",
    "Livré",
    "À régler",
    "Terminé",
    "Annulé"
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //data length
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allOrders?.length,
      itemBuilder: (context, index){
        //store data variable
        var data = allOrders![index] ;
        return Container(
          //margin:const EdgeInsets.only(bottom:5,top: 5),
          padding:const EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
          decoration: BoxDecoration(
            color:index.isEven?Colors.grey.shade100: Colors.grey.shade50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              //Id
              Container(

                  child: TableHeader(name:"${index+1}", width: 30)),


              //Company Name
              TableHeader(name: "${data.company}", width: 120),



              //Payment Method
              SizedBox(
                width: 200,
                child: Container(
                 // margin: EdgeInsets.only(right: 20),
                  width: 150,
                  height: 48,
                  padding: EdgeInsets.only(left: 10,right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Obx(() {
                    // Ensure the current order status exists in the dropdown items
                    var orderStatus = controller.allOrderModel.value.data![index]!.orderStatus;

                    print("orderStatus ---- ${orderStatus}");

                    // List of possible dropdown values
                    final List<String> statusValues = [
                      "En Attente",
                      "Préparation",
                      "Dispatch",
                      "Livraison",
                      "Livré",
                      "À régler",
                      "Terminé",
                      "Annulé"
                    ];

                    // Set a fallback if the current value is not in the list
                    String dropdownValue = statusValues.toString().toLowerCase().contains(orderStatus.toString().toLowerCase())
                        ? orderStatus!
                        : statusValues.first;  // Default to first option if value is invalid

                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: dropdownValue, // Use validated value or fallback
                      onChanged: (value) {
                        controller.orderStatus.value = value.toString();
                        //change order status
                        controller.updateOrderStatus(data.id, value.toString());
                      },
                      items: [
                        DropdownMenuItem(child: Text("Reçue en Attente"), value: "En Attente"),
                        DropdownMenuItem(child: Text("En Préparation"), value: "Préparation"),
                        DropdownMenuItem(child: Text("Prête pour Dispatch"), value: "Dispatch"),
                        DropdownMenuItem(child: Text("En cours de Livraison"), value: "Livraison"),
                        DropdownMenuItem(child: Text("Livré"), value: "Livré"),
                        DropdownMenuItem(child: Text("À régler"), value: "À régler"),
                        DropdownMenuItem(child: Text("Terminé"), value: "Terminé"),
                        DropdownMenuItem(child: Text("Annulé"), value: "Annulé"),
                      ],
                    );
                  }),
                ),
              ),


              //Delivery Address
              Center(
                child: Container(
                  transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                  width: 130,
                  child: AppInput(
                    hint: "INV-00${index+1}",
                    controller: controller.invoiceTextEditingControllerList[index],
                    text: "",
                  ),
                ),
              ),

              Container(
                transform: Matrix4.translationValues(0.0, 0.0, 0.0),

                width: 140,
                child: InkWell(
                  onTap: (){
                    datePickerController.pickDate(context);
                    controller.deliveryDateList[index] = datePickerController.formattedDate.value;
                  },
                  child: Container(
                    height: 48,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Obx(() {
                        return Center(child: Text("${controller.deliveryDateList[index]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black
                          ),
                        ));
                      }
                    ),
                  ),
                )
              ),


              //status

              Container(
                  height: 48,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Center(child: Text("${data.total!.toStringAsFixed(2)} €",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Colors.black
                    ),
                  ))),

              //Date Time
              SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EasyTooltip(
                      text: 'View Invoice',
                      child: IconButton(
                        onPressed: (){
                         // openNewTab(AppRoute.order_invoice, arguments: {"order_id": data.id.toString()});
                          Get.toNamed(AppRoute.order_invoice, arguments: {"order_id": data.id.toString()});
                        },
                        icon: Icon(Icons.featured_play_list, color: Colors.amber, size: 20,),
                      ),
                    ),
                    EasyTooltip(
                      text: 'See Delivery Note',
                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.note_add, color: Colors.green, size: 20,),
                      ),
                    ),
                    EasyTooltip(
                      text: 'See have',
                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.check_circle_outline, color: Colors.indigo, size: 20,),
                      ),
                    )
                  ],
                ),
              ),


              //Action button
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 130,
                  child: Obx(() {
                      return Checkbox(
                        value: controller.selectedOrdersItems.contains(data),
                        onChanged: (bool? value) {
                          if(value == true){
                            controller.selectedOrdersItems.add(data!);
                          }else{
                            controller.selectedOrdersItems.remove(data!);
                          }
                        },

                      );
                    }
                  )
                ),
              ),










            ],
          ),
        );
      },
    );
  }
}
