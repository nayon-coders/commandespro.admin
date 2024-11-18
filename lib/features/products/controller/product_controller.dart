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
  RxList<SingleProducts> singleProductsList = <SingleProducts>[].obs;
  Rx<SingleProducts> selectedSingleProductListModel = SingleProducts().obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  //  getAllProduct();
  }

  //get all product
  Future<List<SingleProducts>?> getAllProduct()async{
    isGettingData.value = true;

    var res = await ApiService().getApi(AppConfig.PRODUCT_GET);
    singleProductsList.clear();
    if(res.statusCode == 200){
      productListModel.value = ProductListModel.fromJson(jsonDecode(res.body));
      for(var i in productListModel.value.data!){
        addProductListTextEditing(i);
        singleProductsList.add(i);
      }

    }
    isGettingData.value = false;

    return  productListModel.value.data;

  }


  // New method to search orders by company name
  void searchOrderByCompanyName(String query) {
    if(query.isEmpty){
      singleProductsList.value = productListModel.value.data!;
      update();
      return;
    } else {
      // Filter the orders based on the company name
      singleProductsList.value = productListModel.value.data!.where((order) =>
          order.name!.toLowerCase().contains(query.toLowerCase()) // Assuming companyName is a field in OrderModel
      ).toList(); // Convert the Iterable to a List
    }
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
      "stock" : productStock.value.text,
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
      "stock" : productStock.value.text,
      "regular_price": restaurantPrice.value.text,
      "selling_price": resellerPrice.value.text,
      "whole_price": wholesalersPrice.value.text,
      "discount_price": productDiscountPrice.value.text,
      "images": convertedImage.isEmpty ? productImages.value : convertedImage,
      "subcategories": subCatListId.value,
    };

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


  // list for
  RxList<TextEditingController> productPurchasePriceList = <TextEditingController>[].obs;
  RxList<TextEditingController> productTypesList = <TextEditingController>[].obs;
  RxList<TextEditingController> stock = <TextEditingController>[].obs;
  RxList<TextEditingController> units = <TextEditingController>[].obs;
  RxList<TextEditingController> origin = <TextEditingController>[].obs;
  RxList<TextEditingController> status = <TextEditingController>[].obs;

  //add add list for product
  addProductListTextEditing(SingleProducts data){
    productPurchasePriceList.add(TextEditingController(text: data.purchasePrice.toString()));
    productTypesList.add(TextEditingController(text: data.productType.toString()));
    stock.add(TextEditingController(text: data.isStock.toString()));
    units.add(TextEditingController(text: data.unit.toString()));
    origin.add(TextEditingController(text: data.country.toString()));
    status.add(TextEditingController(text: data.status.toString()));
  }

  //edit info from list
  RxBool isEditProductList = false.obs;
  editProductList(id, index)async{
    isEditProductList.value = true;


    var data = {
      "product_type": productTypesList[index].value.text,
      "unit": units[index].value.text,
      "country": origin[index].value.text,
      "stock" : stock[index].value.text,
      "purchase_price": productPurchasePriceList[index].value.text,
    };


    var res = await ApiService().putApi(AppConfig.PRODUCT_UPDATE+"$id", data);

    if(res.statusCode == 200){
      getAllProduct();
      Get.snackbar("Success!", "Product updated success", backgroundColor: Colors.green);
      clearAll();
    }else{
      Get.snackbar("Error!", "Something went wrong. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
    getAllProduct();
    isEditProductList.value = false;


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