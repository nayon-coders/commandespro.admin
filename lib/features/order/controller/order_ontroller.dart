import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../app.config.dart';
import '../../../data/model/all_order_model.dart';
import '../../../data/model/single_order_model.dart';
import '../../../data/service/api.service.dart';

class OrderController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllOrder();
  }
RxString orderId = "".obs;
  RxList<OrderItem> selectedOrdersItems = <OrderItem>[].obs;
  Rx<OrderItem> selectedOrder = OrderItem().obs;
  RxBool isAllSelectedOrder = false.obs;

  //order status wise list
  RxList totalPendingOrder = [].obs;
  RxList totalEnPreparations = [].obs;
  RxList totalTerminOrders = [].obs;
  RxList totalDispastOrder = [].obs;
  RxList totalCancelOrder = [].obs;
  RxList totalReturnOrder = [].obs;
  RxList totalshippedr = [].obs;
  RxList<OrderItem> totalOrder = <OrderItem>[].obs;
  RxList totalLivraisonOrder = [].obs;
  RxList totalRegulOrder = [].obs;
  RxList totalCompleteOrder = [].obs;

  //models
  Rx<SingleOrderModel> singleOrderModel = SingleOrderModel().obs;
  Rx<AllOrderModel> allOrderModel = AllOrderModel().obs;
  RxList<OrderItem> exportAllOrderModel = <OrderItem>[].obs;
  RxList<OrderProductItem> exportTotalProduct = <OrderProductItem>[].obs;

  //string
  var orderStatus = "".obs;

  //bools
  var isGettingData = false.obs;
  var isGettingSingleOrder = false.obs;
  var isUpdatingOrderStatus = false.obs;

  //list of bool
  var isSelectedProduct = [].obs;

  //list of text editing controller
  var textEditingController = [].obs;
  RxList<OrderItem> searchResults = <OrderItem>[].obs;
  RxList<TextEditingController> invoiceTextEditingControllerList = <TextEditingController>[].obs;
  RxList<String> deliveryDateList = <String>[].obs;


  //
  var totalNetIncome = 0.0.obs;
  var upcommingIncom = 0.0.obs;
  var pendingIncom = 0.0.obs;
  var cancelIncom = 0.0.obs;


  getAllOrder() async {
    isGettingData.value = true;
    //all list clear
    totalPendingOrder.clear();
    totalEnPreparations.clear();
    totalTerminOrders.clear();
    totalCancelOrder.clear();
    totalReturnOrder.clear();
    totalshippedr.clear();
    totalOrder.clear();
    totalLivraisonOrder.clear();
    totalRegulOrder.clear();
    totalCompleteOrder.clear();


    var response = await ApiService().getApi(AppConfig.ORDER_GET);
    if (response.statusCode == 200) {
      allOrderModel.value = allOrderModelFromJson(response.body);
      for (var i in allOrderModel.value.data!) {
        totalOrder.add(i);

        //store text editing controller
        invoiceTextEditingControllerList.add(TextEditingController());
        deliveryDateList.add(i.deliveryDate!);

        if (i.orderStatus == "En Attente") {
          totalPendingOrder.add(i);
        } else if (i.orderStatus == "Préparation") {
          totalEnPreparations.add(i);
        } else if (i.orderStatus == "Dispatch") {
          //total pending income
          pendingIncom.value += i.total!;
          totalDispastOrder.add(i);
        } else if (i.orderStatus == "Livré") {
          totalTerminOrders.add(i); // total delivery order income
        } else if (i.orderStatus == "return") {
          totalReturnOrder.add(i);
        } else if (i.orderStatus == "shipped") {
          totalshippedr.add(i);
        } else if (i.orderStatus == "Livraison") {
          //total upcomming income
          upcommingIncom.value += i.total!; // upcomming income
          totalLivraisonOrder.add(i); // total in delivery order
        } else if (i.orderStatus == "À régler") {
          totalRegulOrder.add(i);
        } else if (i.orderStatus == "Annulé") {
          totalCancelOrder.add(i); //cancel order income
          cancelIncom.value += i.total!; // cancel order income
        } else if (i.orderStatus == "Terminé") {
          // calulate total net income
          totalNetIncome.value += i.total!;
          print("totalNetIncome ---- ${totalNetIncome}");
          totalCompleteOrder.add(i);
        }
      }
    }
    isGettingData.value = false;
  }

  // New method to search orders by company name
  void searchOrderByCompanyName(String companyName, List<OrderItem> totalOrder) {
    // Ensure the search results list is cleared each time
    searchResults.value = [];
    // totalOrder.refresh();
    print("Searching for ${totalOrder.length}");
    print("Searching for ${searchResults.length}");

    if (companyName.isEmpty) {
      // Return all orders if no search term is provided
      searchResults.value = totalOrder.toSet().toList(); // Remove any duplicates if they exist
    } else {
      // Filter orders by company name, ignoring case
      searchResults.value = totalOrder
          .where((order) => order.company != null && // Check that company is not null
          order.company!.toLowerCase().contains(companyName.toLowerCase()))
          .toSet() // Remove duplicates
          .toList();
    }

    print("Search results: $searchResults");
    update();
  }

  //get single order

  getSingleOrder(String id) async {
    isGettingSingleOrder.value = true;
    var response = await ApiService().getApi(AppConfig.ORDER_GET_SINGLE + id);
    if (response.statusCode == 200) {
      singleOrderModel.value = singleOrderModelFromJson(response.body);
      for (var i in singleOrderModel.value.order!.products!) {
        isSelectedProduct.add(false);
        textEditingController.add(TextEditingController());
      }
    }
    isGettingSingleOrder.value = false;
  }

  void updateOrderStatus(int? id, String value) async {
    isUpdatingOrderStatus.value = true;
    var response = await ApiService().putApi(
        AppConfig.ORDER_STATUS_UPDATE + id.toString(), {"order_status": value});

    if (response.statusCode == 200) {
      //getAllOrder();
   //   getSingleOrder(id.toString());
      Get.snackbar("Success!", "Order status updated successfully",
          backgroundColor: Colors.green);
    }
    isUpdatingOrderStatus.value = false;
  }

  //order product price update
  void updateOrderProductPrice(int? id, int index) async {
    isUpdatingOrderStatus.value = true;

    List<Map<String, dynamic>> products = [];

    for (int i = 0; i < singleOrderModel.value.order!.products!.length; i++) {
      if (i == index) {
        products.add({
          "product_id": singleOrderModel.value.order!.products![i]!.productId!
              .toString(),
          "price": double.parse(textEditingController[i].text).toString(),
          "quantity": singleOrderModel.value.order!.products![i].quantity
              .toString()
        });
      } else {
        products.add({
          "product_id": singleOrderModel.value.order!.products![i].productId!
              .toString(),
          "price": singleOrderModel.value.order!.products![i].price.toString(),
          "quantity": singleOrderModel.value.order!.products![i].quantity
              .toString()
        });
      }
    }

    //make sub total and total from new products list
    var subTotal, total, deliveryFee;
    subTotal = products.fold(0.0, (previousValue, element) {
      return previousValue +
          double.parse(element["price"].toString()) *
              double.parse(element["quantity"].toString());
    });
    deliveryFee = double.parse(subTotal.toString()) > 60 ? 15.00 : 0.00;

    total = subTotal + singleOrderModel.value.order!.taxAmount! + deliveryFee;

    var data = {
      "sub_total": subTotal.toString(),
      "tax": singleOrderModel.value.order!.taxAmount!.toStringAsFixed(2),
      "tax_amount": singleOrderModel.value.order!.taxAmount!.toStringAsFixed(2),
      "delivery_fee": deliveryFee!.toStringAsFixed(2),
      "total": total!.toStringAsFixed(2),
      "products": products
    };
    print("data: $data");
    var response = await ApiService().putApi(
        AppConfig.ORDER_PRICE_UPDATE + id.toString(), data);
    if (response.statusCode == 200) {
      getAllOrder();
      getSingleOrder(id.toString());
      Get.snackbar("Success!", "Order status updated successfully",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    }
    isUpdatingOrderStatus.value = false;
  }


  //order list by from date to to date
  RxBool isGettingExportedOrder = false.obs;

  getExportedOrders(fromDate, toDate) async {
    exportAllOrderModel.clear();
    isGettingExportedOrder.value = true;
    print("url --- ${AppConfig.ORDER_GET +
        "?from_date=$fromDate&to_date=$toDate"}");
    var response = await ApiService().getApi(
        AppConfig.ORDER_GET + "?fromDate=$fromDate&toDate=$toDate");
    if (response.statusCode == 200) {
      var data = AllOrderModel.fromJson(jsonDecode(response.body));
      //add list into export all order model
      for (var i in data.data!) {
        exportAllOrderModel.add(i);
        for (var j in i.products!) {
          exportTotalProduct.add(j);
        }
      }
      isGettingExportedOrder.value = false;
    }
  }




  Color getOrderStatusColor(String status, {bool isFront = true}) {
    switch (status) {
      case "En Attente": // Received Pending
        return Colors.red; // Display on both Front and Back

      case "Préparation": // In Preparation
        return Colors.pinkAccent; // Display on both Front and Back

      case "Dispatch": // Ready for Dispatch
        if (!isFront) {
          return Colors.yellow; // Only display on Back
        }
        break; // Not displayed on Front

      case "Livraison": // In Delivery
        return Colors.cyan; // Display on both Front and Back (Turquoise)

      case "Livré": // Delivered
      // Important: Trigger invoice creation here if needed
        return Colors.purpleAccent; // Display on both Front and Back (Fuchsia)

      case "À régler": // To be Paid
        return Colors.orange; // Display on both Front and Back

      case "Terminé": // Completed
        return Colors.green; // Display on both Front and Back

      case "Annulé": // Canceled
        if (!isFront) {
          return Colors.grey; // Only display on Back
        }
        break; // Not displayed on Front

      default:
        return Colors.transparent; // Default if no match
    }
    return Colors.transparent; // For cases where it's not displayed
  }
}