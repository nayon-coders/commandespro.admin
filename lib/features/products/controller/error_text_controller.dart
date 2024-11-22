import 'package:commandespro_admin/features/products/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductErrorText{

  static  RxString productNameError = "".obs;
  static  RxString productPriceError = "".obs;
  static  RxString productQuantityError = "".obs;
  static  RxString productDescriptionError = "".obs;
  static  RxString productShortDescriptionError = "".obs;
  static  RxString productCategoryError = "".obs;
  static  RxString productDiscountError = "".obs;
  static  RxString productPakeginError = "".obs;
  static  RxString productUnitError = "".obs;
  static  RxString productUnitListError = "".obs;
  static  RxString productStockError = "".obs;
  static  RxString productOriginError = "".obs;
  static  RxString productVatError = "".obs;
  static  RxString productImageError = "".obs;
  static  RxString productSubCategoryError = "".obs;


  static checkError(ProductController controller){
    productNameError.value = controller.productName.value.text.isEmpty ? "This field is required." : "";
    productPriceError.value = controller.productPurchasePrice.value.text.isEmpty ? "This field is required." : "";
    productDescriptionError.value = controller.productDes.value.text.isEmpty ? "This field is required." : "";
    productShortDescriptionError.value = controller.productShortDes.value.text.isEmpty ? "This field is required." : "";
    productCategoryError.value = controller.mainCatId.value.isEmpty ? "This field is required." : "";
    productDiscountError.value = controller.productDiscountPrice.value.text.isEmpty ? "This field is required." : "";
    productUnitError.value = controller.productUnit.value.text.isEmpty ? "This field is required." : "";
    productUnitListError.value = controller.productType.value.isEmpty ? "This field is required." : "";
    productStockError.value = controller.productStock.value.text.isEmpty ? "This field is required." : "";
    productOriginError.value = controller.country.value.isEmpty ? "This field is required." : "";
    productVatError.value = controller.productTex.value.text.isEmpty ? "This field is required." : "";
    productImageError.value = controller.productImages.value.isEmpty ? "This field is required." : "";
    productSubCategoryError.value = controller.subCatListId.value.isEmpty ? "This field is required." : "";
  }

  //check variable is empty or not
  static bool get isError{
    if(productNameError.value.isNotEmpty || productPriceError.value.isNotEmpty || productDescriptionError.value.isNotEmpty || productShortDescriptionError.value.isNotEmpty || productCategoryError.value.isNotEmpty || productDiscountError.value.isNotEmpty || productUnitError.value.isNotEmpty || productUnitListError.value.isNotEmpty || productStockError.value.isNotEmpty || productOriginError.value.isNotEmpty || productVatError.value.isNotEmpty || productImageError.value.isNotEmpty || productSubCategoryError.value.isNotEmpty){
      return true;
    }
    return false;
  }


}