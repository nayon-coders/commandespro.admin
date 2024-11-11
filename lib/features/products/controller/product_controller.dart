import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.config.dart';
import '../../../controller/firebase.image.controller.dart';
import '../../../data/model/product.list.model.dart';
import '../../../data/service/api.service.dart';
class ProductController extends GetxController{



  Rx<TextEditingController> productName = TextEditingController().obs;
  Rx<TextEditingController> productShortDes = TextEditingController().obs;
  Rx<TextEditingController> productDes = TextEditingController().obs;
  Rx<TextEditingController> productUnit = TextEditingController().obs;
  Rx<String> productType = "".obs;
  Rx<TextEditingController> productStock = TextEditingController().obs;
  Rx<TextEditingController> productOrigin = TextEditingController().obs;
  Rx<TextEditingController> productTex = TextEditingController().obs;
  Rx<TextEditingController> productPurchasePrice = TextEditingController().obs;
  Rx<TextEditingController> restaurantPrice = TextEditingController().obs;
  Rx<TextEditingController> resellerPrice = TextEditingController().obs;
  Rx<TextEditingController> wholesalersPrice = TextEditingController().obs;
  Rx<TextEditingController> productDiscountPrice = TextEditingController().obs;
  RxString mainCatId = "".obs;
  RxBool isEdit = false.obs;
  Rx<List<dynamic>> subCatListId = Rx<List<dynamic>>([]);
  Rx<List<dynamic>> subCatListName = Rx<List<dynamic>>([]);
  Rx<List<String>> productImages = Rx<List<String>>([]);
  RxString country = "".obs;
  RxString tax = "".obs;



  RxBool isAddingLoading = false.obs;
  RxBool isGettingData = false.obs;
  RxBool isDeletingData = false.obs;


  Rx<ProductListModel> productListModel = ProductListModel().obs;
  RxList searchResults = [].obs;
  Rx<SingleProducts> selectedSingleProductListModel = SingleProducts().obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  //  getAllProduct();
  }

  //get all product
  getAllProduct()async{
    isGettingData.value = true;
    var res = await ApiService().getApi(AppConfig.PRODUCT_GET);
    if(res.statusCode == 200){
      productListModel.value = ProductListModel.fromJson(jsonDecode(res.body));

    }
    isGettingData.value = false;

  }


  // New method to search orders by company name
  void searchOrderByCompanyName(String companyName) {
    print("searching for $companyName");
    if (companyName.isEmpty) {
      // If the search input is empty, return all orders
      searchResults.value = productListModel.value.data!;
    } else {
      // Filter the orders based on the company name
      searchResults.value = productListModel.value.data!.where((order) =>
          order.name!.toLowerCase().contains(companyName.toLowerCase()) // Assuming companyName is a field in OrderModel
      ).toList(); // Convert the Iterable to a List
    }
    print("searching for $searchResults");
    update();
  }


  //add product
  addProduct(images)async{
    isAddingLoading.value = true;

    //upload image into firebase
    List convertedImage = [];
    for(var i=0; i<images.length; i++){
      convertedImage.add(await FirebaseImageController.uploadImageToFirebaseStorage(images[i], "product_images"));
    }


    var data = {
      "category_id": mainCatId.value,
      "name": productName.value.text,
      "product_type": productType.value,
      "unit": productUnit.value.text,
      "long_description": productDes.value.text,
      "short_description": productShortDes.value.text,
      "tax": tax.value,
      "country": country.value,
      "purchase_price": productPurchasePrice.value.text,
      "regular_price": restaurantPrice.value.text,
      "selling_price": resellerPrice.value.text,
      "whole_price": wholesalersPrice.value.text,
      "discount_price": productDiscountPrice.value.text,
      "images": convertedImage,
      "subcategories": subCatListId.value,
    };
    var res = await ApiService().postApi(AppConfig.PRODUCT_ADD, data);
    if(res.statusCode == 200){
      clearAll();
      Get.snackbar("Success!", "Product added success", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isAddingLoading.value = false;
  }


  //
  //Update product
  updateProduct(images, id)async{
    isAddingLoading.value = true;

    //upload image into firebase
    List convertedImage = [];
    if(images.length != 0){
      for(var i=0; i<images.length; i++){
        convertedImage.add(await FirebaseImageController.uploadImageToFirebaseStorage(images[i], "product_images"));
      }
    }



    var data = {
      "category_id": mainCatId.value,
      "name": productName.value.text,
      "product_type": productType.value,
      "unit": productUnit.value.text,
      "long_description": productDes.value.text,
      "short_description": productShortDes.value.text,
      "tax": tax.value,
      "country": country.value,
      "purchase_price": productPurchasePrice.value.text,
      "regular_price": restaurantPrice.value.text,
      "selling_price": resellerPrice.value.text,
      "whole_price": wholesalersPrice.value.text,
      "discount_price": productDiscountPrice.value.text,
      "images": convertedImage.isEmpty ? productImages.value : convertedImage,
      "subcategories": subCatListId.value,
    };
    print("data ---- ${data}");

    var res = await ApiService().putApi(AppConfig.PRODUCT_UPDATE+"$id", data);


    if(res.statusCode == 200){
      Get.snackbar("Success!", "Product updated success", backgroundColor: Colors.green);
      clearAll();
    }else{
      Get.snackbar("Error!", "Something went wrong. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isAddingLoading.value = false;
  }



  //delete product
  deleteProduct(id)async{
    isDeletingData.value = true;
    var res = await ApiService().deleteApi(AppConfig.PRODUCT_DELETE+"$id");
    if(res.statusCode == 200){
      Get.back();
      getAllProduct();
      Get.snackbar("Success!", "Product has been deleted!", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isDeletingData.value = false;
  }







  updateProductValue()async{
    productImages.value.clear();
    subCatListName.value.clear();
    subCatListId.value.clear();

    isEdit.value = true;

    mainCatId.value = selectedSingleProductListModel.value.id.toString();
    productName.value.text = selectedSingleProductListModel.value.name.toString();
    productType.value = selectedSingleProductListModel.value.productType.toString();
    productUnit.value.text = selectedSingleProductListModel.value.unit.toString();
    productDes.value.text = selectedSingleProductListModel.value.longDescription.toString();
    productShortDes.value.text = selectedSingleProductListModel.value.shortDescription.toString();
    tax.value = selectedSingleProductListModel.value.tax.toString();
    country.value = selectedSingleProductListModel.value.country.toString();
    productPurchasePrice.value.text = selectedSingleProductListModel.value.purchasePrice.toString();
    restaurantPrice.value.text = selectedSingleProductListModel.value.sellingPrice.toString();
    resellerPrice.value.text = selectedSingleProductListModel.value.regularPrice.toString();
    wholesalersPrice.value.text = selectedSingleProductListModel.value.wholePrice.toString();
    productStock.value.text = selectedSingleProductListModel.value.isStock.toString();
    productDiscountPrice.value.text = selectedSingleProductListModel.value.discountPrice.toString();
    for(var i in selectedSingleProductListModel.value.images!){
      productImages.value.add(i.imageUrl.toString());
    }
    for(var i in  selectedSingleProductListModel.value.subcategories!){
      subCatListId.value.add(i.subCategoryId);
      subCatListName.value.add(i.subCategoryName);
    }
  }

  clearAll(){
    isEdit.value = false;
    mainCatId.value = "";
    productName.value.clear();
    productType.value = "";
    productUnit.value.clear();
    productDes.value.clear();
    productShortDes.value.clear();
    tax.value = "";
    country.value = "";
    productPurchasePrice.value.clear();
    restaurantPrice.value.clear();
    resellerPrice.value.clear();
    wholesalersPrice.value.clear();
    productDiscountPrice.value.clear();
    selectedSingleProductListModel.value = SingleProducts();
    productImages.value.clear();
    subCatListName.value.clear();
    subCatListId.value.clear();

  }


}