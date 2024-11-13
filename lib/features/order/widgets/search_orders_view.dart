import 'package:commandespro_admin/features/order/controller/order_ontroller.dart';
import 'package:flutter/material.dart';

import '../../../comman/app_table/table.header.dart';
class SearchOrdersView extends StatelessWidget {
  final OrderController controller;
  const SearchOrdersView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //data length
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index){
        //store data variable
        var data = controller.searchResults[index] ;
        return Container(
          height: 56,
          margin:const EdgeInsets.only(bottom:5,top: 5),
          padding:const EdgeInsets.only(left: 15, right: 15,bottom: 5,top: 5),
          decoration: BoxDecoration(
            color:index.isEven?Colors.grey.shade100: Colors.grey.shade50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Id
              TableHeader(name:"${index+1}", width: 30),
              //Company Name
              TableHeader(name: "${data.company}", width: 150),
              //Payment Method
              TableHeader(name: "${data.paymentMethod}", width: 120),
              //Delivery Address
              TableHeader(name: "${data.userDeliveryAddress!.postCode}, ${data.userDeliveryAddress!.city}, ${data.userDeliveryAddress!.address}", width: 250),
              //status
              //status
              InkWell(
                onTap: (){},
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 120,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: controller.getOrderStatusColor(data.orderStatus!).withOpacity(0.2),
                        border: Border.all(width: 1, color: controller.getOrderStatusColor(data.orderStatus!))
                    ),
                    child: Center(
                      child: Text("${data.orderStatus}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.black),),
                    ),
                  ),
                ),
              ),
              //Date Time
              TableHeader(name: "${data.deliveryDate}", width: 120),
              //Action button
              SizedBox(
                width: 50,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(onPressed: (){
                  }, icon:const Icon(Icons.visibility,color: Colors.green,)),
                ),
              ),
            ],
          ),
        );
      },


    );
  }
}
