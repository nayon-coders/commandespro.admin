import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../../../app.config.dart';
import '../../../controller/firebase.image.controller.dart';
import '../../../data/model/main.category.model.dart';
import '../../../data/service/api.service.dart';

class CategoryController extends GetxController{


  Rx<Uint8List?> mainCatImage = Rx<Uint8List?>(null);
  Rx<Uint8List?> subCatImage = Rx<Uint8List?>(null);

  Rx<TextEditingController> categoryName = TextEditingController().obs;
  Rx<TextEditingController> subCategoryName = TextEditingController().obs;
  RxString mainCatId = "".obs;
  Rx<MainCategoryModel> mainCategoryModel = MainCategoryModel().obs;
  Rx<SingleCategory> singleMainCategory = SingleCategory().obs;
  Rx<List<SingleCategory>> subCatList = Rx<List<SingleCategory>>([]);
  Rx<SingleCategory> singleSubCat = SingleCategory().obs;
  Rx<SingleCategory> editSingleCategory = SingleCategory().obs;

  RxString selectedId = "".obs;

  var isLoading = false.obs;
  var isGettingSubCategory = false.obs;
  var isAddingSubCat = false.obs;
  var isDataGetting = false.obs;
  var isDataUpdating = false.obs;
  var isDataDeleting = false.obs;


  onInit(){
    super.onInit();
    getMainCategory();
  }


  // Add a method to create a new category
  Future<void> createCategory() async {
    isLoading.value = true;
    try {
      var convertImage = await FirebaseImageController.uploadImageToFirebaseStorage(mainCatImage.value!, "main_category_image");

      print("Image --- ${convertImage}");
      var data = {
        "category_name": categoryName.value.text,
        "category_image": convertImage
      };

      var response = await ApiService().postApi(AppConfig.CATEGORY_MAIN_ADD, data);

      if (response.statusCode == 200) {
        clearImage();
        clearInputText();
        getMainCategory();
        Get.snackbar("Success!", "Category create success!", backgroundColor: Colors.green);
      } else {
        // Handle error
        Get.snackbar("Error!", "Error uploading image: ${response.statusCode}", backgroundColor: Colors.red);
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    isLoading.value = false;
  }


  // edit a method to create a new category
  Future<void> updateCategory() async {
    isLoading.value = true;
    try {
      var convertImage;
      if(mainCatImage.value != null){
        convertImage = await FirebaseImageController.uploadImageToFirebaseStorage(mainCatImage.value!, "main_category_image");
      }else{
        convertImage = editSingleCategory.value?.image;
      }

      print("convertImage ---- ${convertImage}");
      print("categoryName.value.tex ---- ${categoryName.value.text}");

      var data = {
        "category_name": categoryName.value.text ?? "",
        "category_image": convertImage  ?? editSingleCategory.value.image
      };

      print("data ---- ${data}");

      var response = await ApiService().putApi(AppConfig.CATEGORY_MAIN_UPDATE+"$selectedId" ,  data, );

      if (response.statusCode == 200) {
        isLoading.value = false;
        clearImage();
        clearInputText();
        getMainCategory();
        Get.snackbar("Success!", "Category update success!", backgroundColor: Colors.green);

      } else {
        // Handle error
        Get.snackbar("Error!", "Error uploading image: ${response.statusCode}", backgroundColor: Colors.red);
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    isLoading.value = false;
  }



  //get the main category
  getMainCategory()async{
    isDataGetting.value = true;
    var res = await ApiService().getApi(AppConfig.CATEGORY_MAIN_GET);
    if(res.statusCode == 200){
      mainCategoryModel.value = MainCategoryModel.fromJson(jsonDecode(res.body));
      singleMainCategory.value = mainCategoryModel.value.data![0];
    }
    isDataGetting.value = false;
  }


  //delete category
  deleteMainCategory(id)async{
    isDataDeleting.value = true;
    var res = await ApiService().deleteApi(AppConfig.CATEGORY_MAIN_DELETE+"$id", );
    if(res.statusCode == 200){
      Get.snackbar("Success!", "Category deleted success", backgroundColor: Colors.green);
      getMainCategory();
      clearImage();
    }else{
      Get.snackbar("Error!", "Something is wrong with server. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isDataDeleting.value = false;
  }






/////////////////--------------------- sub category -----------------------------////////
  Future addSubCategory(imagePath)async{
    isAddingSubCat.value = true;

    // Convert Uint8List to Base64
    var convertImage = await FirebaseImageController.uploadImageToFirebaseStorage(subCatImage.value!, "sub_category_image");

    final response = await http.post(
      Uri.parse(AppConfig.SUB_CATEGORY_CREATE),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': subCategoryName.value.text, // The name of the category
        'main_cat_id': mainCatId.value, // The name of the category
        'image': convertImage, // The Base64 image data
      }),
    );
    // Handle the response
    if (response.statusCode == 200) {
      isAddingSubCat.value = false;
      getMainCategory();
      clearImage();
      clearInputText();
      Get.snackbar('Success', 'Sub Category created successfully' ,backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed to create sub category', backgroundColor: Colors.red);
    }
    isAddingSubCat.value = false;

  }


  //delete sub category
  deleteSubCategory(id)async{
    isDataDeleting.value = true;
    var res = await ApiService().deleteApi(AppConfig.SUB_CATEGORY_DELETE+"$id");
    if(res.statusCode == 200){
      Get.snackbar("Success!", "Sub Category deleted success", backgroundColor: Colors.green);
      getMainCategory();
    }else{
      Get.snackbar("Error!", "Something is wrong with server. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
    isDataDeleting.value = false;
  }

  //orientation category update
  orientationCategoryUpdate(SingleCategory item, String index)async{
   // isDataUpdating.value = true;
    var data =  {
      "sn_number": index,
      "category_name": "${item.name}",
      "category_image": "${item.image}",
    };
    print("data --- ${data}");
    var res = await ApiService().putApi(AppConfig.CATEGORY_MAIN_UPDATE+"${item.id.toString()}", data);
    if(res.statusCode == 200){
      Get.snackbar("Success!", "Category oriantation  updated success", backgroundColor: Colors.green);
      getMainCategory();
    }else{
      Get.snackbar("Error!", "Something is wrong with server. Status Code: ${res.statusCode}", backgroundColor: Colors.red);
    }
   // isDataUpdating.value = false;
  }

  orientationSubCategoryUpdate(SingleCategory item, String index)async{
    // isDataUpdating.value = true;
    var data =  {
      "sn_number": index,
      "name": "${item.name}",
      "image": "${item.image}",
    };
    print("data --- ${data}");
    var res = await ApiService().putApi(AppConfig.SUB_CATEGORY_UPDATE+"${item.id.toString()}", data);
    print("res --- ${res.body}");
    if(res.statusCode == 200){
     // getMainCategory();
    }else{
    }
    // isDataUpdating.value = false;
  }




  /////////
  categoryCallBack(data){
    mainCatImage.value = data;
  }

  subCategoryCallBack(data){
    subCatImage.value = data;
  }


  clearImage(){
    mainCatImage.value = null;
    subCatImage.value = null;
  }

  clearInputText(){
    categoryName.value.clear();
    subCategoryName.value.clear();
    selectedId.value = "";
  }




}