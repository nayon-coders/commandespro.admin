import 'dart:convert';

import 'package:commandespro_admin/app.config.dart';
import 'package:commandespro_admin/data/model/all_delivery_address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../../../data/model/product.list.model.dart';
import '../../../data/model/user.list.model.dart';
import '../../../data/service/api.service.dart';
import '../../products/controller/product_controller.dart';

class CMDController extends GetxController{
final ProductController productController = Get.put(ProductController());



  RxString selectedCustomerName = "".obs;
Rx<UserList> selectedUser = UserList().obs;

RxString deliveryDate = "".obs;
RxString paymentMethod = "".obs;
RxList paymentMethodList = <String>["SEPA Direct Debit", "CB", "Paypal", "Credit Card"].obs;

  RxList<Map> products = <Map>[].obs;
  Rx<SingleProducts> selectedProduct = SingleProducts().obs;
  Rx<AllDeliveryAddressByIdModel> allDeliveryAddress = AllDeliveryAddressByIdModel().obs;
  Rx<DeliveryAddressModel> selectedDeliveryAddress = DeliveryAddressModel().obs;
  RxList<SingleProducts> selectedProductList = <SingleProducts>[].obs;
  RxList<TextEditingController> quantity = <TextEditingController>[].obs;
  RxList<TextEditingController> comment = <TextEditingController>[].obs;

  RxBool isOrderCreating = false.obs;
  RxBool isAddressCreating = false.obs;

  //total price calculation
  RxList<double> totalProductPrice = <double>[].obs;
  RxList<double> totalProductPriceWithTax = <double>[].obs;
  RxList<double> totalTaxRateList = <double>[].obs;
  RxDouble totalDiscount = 0.0.obs;
  RxList<double> totalTaxList = <double>[].obs;
  RxList<double> totalTaxPercentList = <double>[].obs;
  RxDouble totalTax = 0.0.obs;
  RxDouble totalTaxRate = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble subTotal = 0.0.obs;
  RxDouble deliveryCost = 0.0.obs;

  RxBool isAddressGetting = false.obs;

  //get all delivery address by id
  getAllDeliveryAddress()async{
    isAddressGetting.value = true;
    selectedDeliveryAddress.value = DeliveryAddressModel();
    var response = await ApiService().getApi(AppConfig.all_delivery_address+"${selectedUser.value.id}");
    if(response.statusCode == 200){
      allDeliveryAddress.value = AllDeliveryAddressByIdModel.fromJson(jsonDecode(response.body));
      if(allDeliveryAddress.value.data != null){
        selectedDeliveryAddress.value = allDeliveryAddress.value.data![0];
      }
    }else{
      Get.snackbar("Error", "No address found. Create a new address for delivery!", backgroundColor: Colors.red, colorText: Colors.white);
      allDeliveryAddress.value = AllDeliveryAddressByIdModel();
    }
    isAddressGetting.value = false;
  }

  //create address
   Rx<TextEditingController> deliveryAddressController = TextEditingController().obs;
  Rx<TextEditingController> deliveryCityController = TextEditingController().obs;
  Rx<TextEditingController> deliveryZipController = TextEditingController().obs;
  Rx<TextEditingController> deliveryContactController = TextEditingController().obs;
  Rx<TextEditingController> deliveryPhoneController = TextEditingController().obs;
  Rx<TextEditingController> deliveryPostCodeController = TextEditingController().obs;

  //Create address for delivery
  createAddress()async{
    isAddressCreating.value = true;
    var data = {
      "phone": deliveryPhoneController.value.text,
      "contact": deliveryContactController.value.text,
      "address": deliveryAddressController.value.text,
      "address_type": "HOME",
      "city": deliveryCityController.value.text,
      "post_code": deliveryPostCodeController.value.text,
      "message": "N/A"
    };
    var response = await ApiService().postApi(AppConfig.ADD_DELIVERY_ADDRESS+"${selectedUser.value.id}", data);
    if(response.statusCode == 200){
      getAllDeliveryAddress();
      Get.back();
      Get.snackbar("Success", "Address created successfully", backgroundColor: Colors.green, colorText: Colors.white);
      isAddressCreating.value = false;
    }else{
      Get.snackbar("Error", "Failed to create address", backgroundColor: Colors.red, colorText: Colors.white);
      isAddressCreating.value = false;
    }

  }

  //create order
  createOrder()async{

    isOrderCreating.value = true;
    for(var i in selectedProductList.value){
      products.add( {
        "product_id": i.id.toString(),
        "quantity": quantity[selectedProductList.value.indexOf(i)].text,
        "price": totalProductPrice[selectedProductList.value.indexOf(i)].toString(),
      });
    }

    var data = {
      "company": selectedUser.value.company.toString(),
      "delivery_date": deliveryDate.value,
      "payment_method": paymentMethod.value,
      "sub_total": subTotal.value,
      "tax": totalTax.value,
      "tax_amount": totalTax.value,
      "delivery_fee": deliveryCost.value,
      "total": totalAmount.value.toStringAsFixed(2),
      "user_delivery_address_id": selectedDeliveryAddress.value.id.toString(),
      "products": products.value
    };
    var response = await ApiService().postApi(AppConfig.CREART_ORDER+"${selectedUser.value.id.toString()}", data);
    if(response.statusCode == 200){
      Get.snackbar("Success", "Order created successfully", backgroundColor: Colors.green, colorText: Colors.white);
      clearAllProduct();
    }else{
      Get.snackbar("Error", "Failed to create order", backgroundColor: Colors.red, colorText: Colors.white);
    }
    isOrderCreating.value = false;
  }



totalPriceCalculation(int index) {
  // Ensure lists are large enough to hold the index
  while (index >= totalProductPrice.length) {
    totalProductPrice.add(0.0);
    totalProductPriceWithTax.add(0.0);
    totalTaxList.add(0.0);
    totalTaxRateList.add(0.0);
  }

  String accountType = selectedUser.value.accountType?.toLowerCase() ?? "";

  double price = 0.0;
  if (accountType.contains("restauration")) {
    price = double.tryParse("${selectedProductList[index].regularPrice}") ?? 0;
  } else if (accountType.contains("revendeur")) {
    price = double.tryParse("${selectedProductList[index].sellingPrice}") ?? 0;
  } else if (accountType.contains("grossiste")) {
    price = double.tryParse("${selectedProductList[index].wholePrice}") ?? 0;
  }

  double qty = double.tryParse(quantity[index].text.toString()) ?? 0;
  totalProductPrice[index] = price * qty;

  double taxRate = double.tryParse("${selectedProductList[index].tax}") ?? 0;
  print("taxRate --- ${taxRate}");
  totalTaxRateList[index] = taxRate;
  double totalTax = (totalProductPrice[index] / 100) * taxRate;


  totalProductPriceWithTax[index] = totalProductPrice[index] + totalTax;
  totalTaxList[index] = totalTax;

  totalTaxCalculation();
  totalAmountCalculation();
  subTotalCalculation();

  update(); // Notify listeners
}

// Calculate total tax %
  totalTaxCalculation() {
    totalTax.value = totalTaxList.value.reduce((value, element) => value + element);
    totalTaxRate.value = totalTaxRateList.value.reduce((value, element) => value + element);
    update();
    print("total tax amount ---- ${totalTax.value}");
  }


  //calculate total discount
  totalDiscountCalculation() {
    double total = 0.00;
    for (int i = 0; i < totalProductPrice.length; i++) {
      total += double.parse("${selectedProductList[i].sellingPrice}");
    }
    totalDiscount.value = total;
    update();
  }

  //calculate total amount
  totalAmountCalculation() {
    totalAmount.value = 0.00;
    deliveryCost.value = 0.00;
    totalAmount.value = totalProductPriceWithTax.map((e) => e).reduce((value, element) => value + element);
    if(totalAmount.value >= 60){
      deliveryCost.value = 15.00;
    }
    update();
  }

  //calculate sub total
  subTotalCalculation() {
    subTotal.value = 0.00;
    subTotal.value = totalProductPrice.map((e) => e).reduce((value, element) => value + element);
    update();
  }

  //remove product from list
  removeProduct(int index) {
    totalProductPrice.removeAt(index);
    totalProductPriceWithTax.removeAt(index);
    selectedProductList.removeAt(index);
    quantity.removeAt(index);
    comment.removeAt(index);
    totalAmountCalculation();
    totalDiscountCalculation();
    totalTaxCalculation();
    subTotalCalculation();
    update();
  }

  //update product quantity
  updateProductQuantity(int index) {
    totalPriceCalculation(index);
    totalAmountCalculation();
    totalDiscountCalculation();
    totalTaxCalculation();
    subTotalCalculation();
    update();
  }

  //update product comment
  updateProductComment(int index) {
    update();
  }

  //update product
  updateProduct(int index) {
    totalPriceCalculation(index);
    totalAmountCalculation();
    totalDiscountCalculation();
    totalTaxCalculation();
    subTotalCalculation();
    update();
  }

  //clear all product
  clearAllProduct() {
    totalProductPrice.clear();
    totalProductPriceWithTax.clear();
    selectedProductList.clear();
    quantity.value.clear();
    comment.value.clear();
    totalAmount.value = 0.0;
    totalDiscount.value = 0.0;
    totalTax.value = 0.0;
    totalTaxRate.value = 0.0;
    subTotal.value = 0.0;
    deliveryCost.value = 0.0;

    deliveryDate.value = "";
    paymentMethod.value = "";
    products.clear();
    selectedProductList.clear();
    totalProductPrice.clear();
    totalProductPriceWithTax.clear();
    totalTaxList.clear();
    totalTaxRateList.clear();
    totalTaxPercentList.clear();

    update();
  }

}