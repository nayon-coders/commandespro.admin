import 'dart:convert';

import 'package:commandespro_admin/data/model/admin_profile_model.dart';
import 'package:commandespro_admin/data/model/all_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../app.config.dart';
import '../../../data/model/product.list.model.dart';
import '../../../data/model/single_customer_model.dart';
import '../../../data/service/api.service.dart';


class PrintController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isGettingData = false.obs;
  Rx<SingleCustomerModel> singleCustomerModel = SingleCustomerModel().obs;

  Rx<ProductListModel> productListModel = ProductListModel().obs;

  //get single user
  Future getSingleUser(id)async{
    isLoading.value = true;
    print("this is single user id --- ${id}");
    var res = await ApiService().getApi(AppConfig.USER_SINGLE+"${id}");
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      singleCustomerModel.value = SingleCustomerModel.fromJson(data);
      isLoading.value = false;
      return;
    }else{

      isLoading.value = false;
    }
  }

  //get all product
  Future<List<SingleProducts>?> getAllProduct()async{
    isGettingData.value = true;

    var res = await ApiService().getApi(AppConfig.PRODUCT_GET);
    if(res.statusCode == 200){
      productListModel.value = ProductListModel.fromJson(jsonDecode(res.body));
    }
    isGettingData.value = false;

    return  productListModel.value.data;

  }



  //prepare order invoice model
  preparInvoiceModel(List<SingleProducts> productList, List<OrderItem> orderList, AdminProfileModel admin){

    List product = [];
    List allProductId = [];

    for(var i in productList){
      allProductId.add(i.id.toString());
    }
    for(var i =0; i<orderList.length; i++){
      for(var j = 0; j<orderList[i].products!.length; j++){
        if(allProductId.contains(orderList[i].products![j].productId.toString())){
          product.add({
            "product": "${orderList[i].products![j].name}",
            "lastPrice": "${orderList[i].total!.toStringAsFixed(2)}",
            "quantityOrdered": "${orderList[i].products![j].quantity}",
            "commandedUnit": productList.where((element) => element.id == orderList[i].products![j].productId).first.productType,
            "knownStock": productList.where((element) => element.id == orderList[i].products![j].productId).first.isStock,
            "stockUnit":  productList.where((element) => element.id == orderList[i].products![j].productId).first.unit,
          });
        }
      }
    }

      // Get the current DateTime
      DateTime now = DateTime.now();

      // Define the desired format
      String formattedDate = DateFormat('EEEE, MMMM d, y \'at\' h:mm a').format(now);



      return {
      "title": "Preparation of the day's orders",
      "dateTime": formattedDate,
      "printedBy": "${admin.firstName} ${admin.lastName}",
      "orders": product
    };
  }


  invoicePrintModel(OrderItem order, String invoiceNumber, String invoiceDate, SingleCustomerModel customer){

    List products = [];
    print("order.products! --- ${order.products!.length}");
    for(var i in order.products!){
      products.add({
        "name": "${i.name}",
        "quantity": i.quantity,
        "price": i.price
      });
    }

      return {
        "invoiceNo": "${invoiceNumber}",
        "invoiceDate": "${invoiceDate}",
        "orderNo": "${order.id}",
        "orderDate": "${DateFormat('dd/MM/yyyy').format(DateTime.parse("${order.deliveryDate}") ?? DateTime.now())}",
        "billingAddress": {
          "name": "${customer.name}",
          "street": "${customer.siret}",
          "city": "${customer.city}",
          "zip": "${customer.postCode}",
          "country": "France",
          "email": "${customer.email}",
        },
        "deliveryAddress": {
          "name": "${customer.name}",
          "street": "${order.userDeliveryAddress!.address}",
          "city": "${order.userDeliveryAddress!.city}",
          "zip": "${order.userDeliveryAddress!.postCode}",
          "country": "France",
          "contact": "${order.userDeliveryAddress!.phone}",
        },
        "products": products,
        "totals": {
          "subtotal": order.subTotal!,
          "vat":order.taxAmount,
          "total": order.total!,
        }
      };
  }

}