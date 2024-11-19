import 'dart:convert';

import 'package:commandespro_admin/data/model/all_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../app.config.dart';
import '../../../data/model/single_customer_model.dart';
import '../../../data/service/api.service.dart';


class PrintController extends GetxController {

  RxBool isLoading = false.obs;
  Rx<SingleCustomerModel> singleCustomerModel = SingleCustomerModel().obs;

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


  //prepare order invoice model
  preparInvoiceModel(OrderItem orderItem){

    List product = [];
    for(var i in []){
      product.add( {
        "product": "White Mushrooms STD - Kg",
        "lastPrice": "2.99",
        "quantityOrdered": 12,
        "commandedUnit": "Kg",
        "knownStock": 20,
        "stockUnit": "Kg"
      });
    }
    return {
      "title": "Preparation of the day's orders",
      "dateTime": "Saturday, July 27, 2024 at 3:45 p.m.",
      "printedBy": "Farid BELMAHI",
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