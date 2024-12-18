import 'package:commandespro_admin/comman/error_text.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/products/controller/error_text_controller.dart';
import 'package:commandespro_admin/features/products/controller/product_controller.dart';
import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:commandespro_admin/utility/text_style.dart';
import 'package:commandespro_admin/comman/app_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/dropdown2.dart';
import '../../../controller/firebase.image.controller.dart';
import '../../../controller/image.picker.controller.dart';
import '../../../controller/product_json.dart';
import '../../../data/model/main.category.model.dart';
import '../../menus/screens/top_bar.dart';
import '../controller/category.controller.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final ProductController controller = Get.find();
  ImagePickerController imagePickerController = Get.put(ImagePickerController());
  final CategoryController _categoryController = Get.put(CategoryController());


  List images = [];
  //store image
  uploadImage(file){
    setState(() {
      images.add(file);
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Container(
            width: Get.width,
            padding: isMobile ? EdgeInsets.all(10) : EdgeInsets.only(left: 100, right: 100, top: 40, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: ()=>Get.toNamed(AppRoute.product_list),
                      icon: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 4,),
                    Obx(() {
                        return Text( " ${controller.isEdit.value ? "Edit Product" : "Add Product"}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    ),
                  ],
                ),
                SizedBox(height: 20,),

                 Form(
                   key: controller.formKey,
                   child: Builder(
                     builder: (context) {
                       if(isMobile){
                         return _buildMobileView(context);
                       }else{
                         return _buildWebView(isMobile, context);
                       }

                     }
                   ),
                 ),
                SizedBox(height: 30,),
                Obx((){
                    return InkWell(
                      onTap: ()async {
                        AddProductErrorText.checkError(controller);

                        if (controller.formKey.currentState!.validate()) {
                          if (AddProductErrorText.isError == false) {
                            if (controller.isEdit.value) {
                              await controller.updateProduct(images,
                                  controller.selectedSingleProductListModel
                                      .value.id.toString());
                            } else {
                              await controller.addProduct(images);
                            }
                          }else{
                            controller.productPageHeight.value =  controller.productPageHeight.value + 80;
                            Get.snackbar("Error!", "Please fill all the required field", backgroundColor: Colors.red, colorText: Colors.white);
                          }
                        }else{
                          controller.productPageHeight.value =  controller.productPageHeight.value + 100;
                        }
                      },
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Center(
                            child: controller.isAddingLoading.value ? CircularProgressIndicator(color: Colors.white,) : Text("Save", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
          );
        }
      )
    );
  }

  Row _buildWebView(bool isMobile, BuildContext context) {
    return Row(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Expanded(
             child: Obx(() {
                 return Container(
                   height: isMobile ? controller.productPageMobileHeight.value : controller.productPageHeight.value,
                   padding: EdgeInsets.all(AppPadding.defaultPadding),
                   decoration: BoxDecoration(
                     color: AppColors.lighGry,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.shade300,
                         spreadRadius: 1,
                         blurRadius: 2,
                         offset: const Offset(0, 0), // changes position of shadow
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Product Details",
                         style: formTitleStyle(),
                       ),
                       SizedBox(height: 20,),
                       AppInput(text: "Product Sheet", hint: "Product Name", controller: controller.productName.value),
                       SizedBox(height: 20,),
                       //short description Dropdown
                       Text("Packaging",
                         style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       SizedBox(height: 10,),
                       DropDown2(
                           items: ProductJson.descriptionList,
                           value:  controller.productShortDes.value.text.isNotEmpty ?  controller.productShortDes.value.text : null,
                           hint: "select Packaging", onChange: (v){setState(() {
                         controller.productShortDes.value.text = v!;
                       });}),
                       SizedBox(height: 5,),
                       AddProductErrorText.productShortDescriptionError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productShortDescriptionError.value),

                       SizedBox(height: 20,),
                       AppInput(text: "Product Description", hint: "A details description of you product (Min 200 Characters)", maxLine: 6, controller: controller.productDes.value),
                       SizedBox(height: 20,),
                       AppInput(text: "Weigh in Kg, Volume inL, or unit", hint: "Unit", controller: controller.productUnit.value),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           Expanded(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Product Unit",
                                   style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 DropDown2(
                                     items: ProductJson.productTypeList,
                                     hint: "Product Unit",
                                     value: controller.productType.value.isNotEmpty ?  controller.productType.value :  null,
                                     onChange: (v){
                                       setState(() {
                                         controller.productType.value = v!.toString();
                                       });
                                     }),
                                 SizedBox(height: 5,),
                                 AddProductErrorText.productUnitListError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productUnitListError.value),
                               ],
                             ),
                           ),
                           SizedBox(width: 20,),
                           Expanded(child: AppInput(text: "In Stock", hint: "1", controller: controller.productStock.value)),
                         ],
                       ),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           Expanded(
                             child:  Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Origin",
                                   style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 DropDown2(
                                     items: ProductJson.allCountry,
                                     hint: "Origin",
                                     value: controller.country.value.isNotEmpty ?  controller.country.value :  null,
                                     onChange: (v){
                                       setState(() {
                                         controller.country.value = v!.toString();
                                       });
                                     }),

                                 SizedBox(height: 5,),
                                 AddProductErrorText.productOriginError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productOriginError.value),
                               ],
                             ),
                           ),
                           SizedBox(width: 20,),
                           Expanded(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("VAT(%)",
                                   style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 Obx(() {
                                     return DropDown2(
                                       items: controller.vatList.value,
                                        value: controller.vatList.value.contains(controller.productTex.value.text) ? controller.productTex.value.text : null,
                                       onChange: (v){
                                           controller.productTex.value.text = v!;

                                       },
                                       hint: 'Select VAT%',

                                     );
                                   }
                                 ),
                                 SizedBox(height: 5,),
                                 AddProductErrorText.productVatError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productVatError.value),
                               ],
                             ),
                           )
                         ],
                       ),
                       SizedBox(height: 20,),
                       Text("Product Image",
                         style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       SizedBox(height: 10,),
                       Row(
                         children: [
                           InkWell(
                             onTap: () async {
                               if(images.length < 5){
                                 await FirebaseImageController.startWebFilePicker(uploadImage);
                               }else{
                                 Get.snackbar("Error!", "Max uplod 5 Image", backgroundColor: Colors.red, colorText: Colors.white);
                               }
                             },
                             child: DottedBorder(
                               borderType: BorderType.RRect,
                               radius: Radius.circular(12),
                               padding: EdgeInsets.all(20),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(12)),
                                 child: Icon(Icons.upload_file_outlined, color: AppColors.primaryColor, size: 20,),
                               ),
                             ),
                           ),
                           SizedBox(width: 20,),
                           images.isNotEmpty
                               ? Expanded(
                             child: GridView.builder(
                               itemCount: images.length > 5 ? 5 : images.length,
                               shrinkWrap: true,
                               physics: NeverScrollableScrollPhysics(),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 5,
                                   crossAxisSpacing: 10,
                                   mainAxisSpacing: 10,
                                   mainAxisExtent: 80
                               ),
                               itemBuilder: (context, index){
                                 var data = images[index];
                                 return Stack(
                                   children: [
                                     Container(
                                       width: 100,
                                       height: 100,
                                       margin:
                                       const EdgeInsets.all(10),
                                       decoration: BoxDecoration(
                                           borderRadius:
                                           BorderRadius.circular(
                                               10),
                                           border: Border.all(
                                               width: 1,
                                               color: Colors.green)),
                                       child: Image.memory(data!, fit: BoxFit.cover,),
                                     ),
                                     Positioned(
                                       right: 15,
                                       top: 15,
                                       child: Container(
                                         decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius:
                                             BorderRadius.circular(
                                                 100)),
                                         child: InkWell(
                                             onTap: () {
                                               setState(() {
                                                 images.removeAt(index);
                                               });
                                             },
                                             child: Icon(
                                               Icons.delete,
                                               color: Colors.red,
                                               size: 15,
                                             )),
                                       ),
                                     )
                                   ],
                                 );
                               },
                             ),
                           )
                               :controller.productImages.value.isNotEmpty
                               ? Expanded(
                             child: GridView.builder(
                               itemCount: controller.productImages.value.length ,
                               shrinkWrap: true,
                               physics: NeverScrollableScrollPhysics(),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 5,
                                   crossAxisSpacing: 10,
                                   mainAxisSpacing: 10,
                                   mainAxisExtent: 80
                               ),
                               itemBuilder: (context, index){
                                 var data = controller.productImages.value[index];
                                 return Stack(
                                   children: [
                                     Container(
                                       width: 100,
                                       height: 100,
                                       margin:
                                       const EdgeInsets.all(10),
                                       decoration: BoxDecoration(
                                           borderRadius:
                                           BorderRadius.circular(
                                               10),
                                           border: Border.all(
                                               width: 1,
                                               color: Colors.green)),
                                       child: Image.network(data!, fit: BoxFit.cover,),
                                     ),
                                     Positioned(
                                       right: 15,
                                       top: 15,
                                       child: Container(
                                         decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius:
                                             BorderRadius.circular(
                                                 100)),
                                         child: InkWell(
                                             onTap: () {
                                               setState(() {
                                                 controller.productImages.value.removeAt(index);
                                               });
                                             },
                                             child: Icon(
                                               Icons.delete,
                                               color: Colors.red,
                                               size: 15,
                                             )),
                                       ),
                                     )
                                   ],
                                 );
                               },
                             ),
                           )
                               : Center()
                         ],
                       ),
                       SizedBox(height: 5,),
                       images != null || images.isEmpty ? const Center() : const ErrorText(text:"This filed is required!"),
                     ],
                   ),
                 );
               }
             ),
           ),
           SizedBox(width: 20,),
           Expanded(
             child: Obx(() {
                 return Container(
                   height:   controller.productPageHeight.value,
                   padding: EdgeInsets.all(AppPadding.defaultPadding),
                   decoration: BoxDecoration(
                     color: AppColors.lighGry,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.shade300,
                         spreadRadius: 1,
                         blurRadius: 2,
                         offset: const Offset(0, 0), // changes position of shadow
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Pricing",
                         style: formTitleStyle(),
                       ),
                       SizedBox(height: 20,),
                       AppInput(text: "Purchase Price (excle. tax)", hint: "Purchase Price (excle. tax)", controller: controller.productPurchasePrice.value,
                         onChanged: (v){
                           controller.restaurantPrice.value.text = ((double.parse(v) / 100) * 42 + double.parse(v)).toStringAsFixed(2);
                           controller.resellerPrice.value.text = ((double.parse(v) / 100) * 25 + double.parse(v)).toStringAsFixed(2);
                           controller.wholesalersPrice.value.text = ((double.parse(v) / 100) * 15 + double.parse(v)).toStringAsFixed(2);
                           controller.supperMarcent.value.text = ((double.parse(v) / 100) * 10 + double.parse(v)).toStringAsFixed(2);
                         },
                       ),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           Expanded(child: AppInput(text: "Prix Revendeurs (+25%)", hint: "Prix Revendeurs ", readOnly: true, controller: controller.resellerPrice.value)),
                           SizedBox(width: 20,),
                           Expanded(child: AppInput(text: "Prix Restaurants  (+42%)", hint: "Prix Restaurants ",   readOnly: true, controller: controller.restaurantPrice.value)),
                         ],
                       ),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           Expanded(child: AppInput(text: "Prix Grossistes (+15%)", hint: "Prix Grossistes ",  readOnly: true,  controller: controller.wholesalersPrice.value)),
                           SizedBox(width: 20,),
                           Expanded(child: AppInput(text: "Prix supermarché.  (+10%)", hint: "Prix supermarché.  ",  readOnly: true,  controller: controller.supperMarcent.value)),

                         ],
                       ),
                       SizedBox(height: 20,),
                       AppInput(text: "Discount (%)", hint: "Discount (%)", controller: controller.productDiscountPrice.value, isValidatorNeed: false, ),

                       SizedBox(height: 20,),
                       Text("Select One Or More Category",
                         style: formTitleStyle(),
                       ),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           Expanded(
                             child: Column(
                               children: [
                                 Obx(() {
                                   // Check if mainCategoryModel.value or data is null
                                   if (_categoryController.isLoading.value) {
                                     return Center(); // Loading state
                                   } else if (_categoryController.mainCategoryModel.value?.data == null ||
                                       _categoryController.mainCategoryModel.value.data!.isEmpty) {
                                     return Center(child: Text('No categories available')); // When data is empty or null
                                   } else {
                                     return DropdownButtonHideUnderline(
                                       child: DropdownButton2<SingleCategory>(
                                         isExpanded: true,
                                         hint: Text(
                                           'Select Main Category',
                                           style: TextStyle(
                                             fontSize: 14,
                                             color: Theme.of(context).hintColor,
                                           ),
                                         ),
                                         items: _categoryController.mainCategoryModel.value.data!.map((item) {
                                           return DropdownMenuItem<SingleCategory>(
                                             value: item,
                                             child: Text(
                                               item.name ?? '', // Add null safety check here
                                               style: const TextStyle(
                                                 fontSize: 14,
                                               ),
                                             ),
                                           );
                                         }).toList(),
                                         value: _categoryController.mainCategoryModel.value.data!
                                             .contains(_categoryController.singleMainCategory.value)
                                             ? _categoryController.singleMainCategory.value
                                             : null, // Ensure a valid value is selected
                                         onChanged: (value) {
                                           if (value != null) {
                                             _categoryController.singleMainCategory.value = value;
                                             _categoryController.subCatList.value = value.subCategories ?? [];
                                             controller.mainCatId.value = value.id.toString();
                                           }
                                         },
                                         buttonStyleData: ButtonStyleData(
                                           padding: EdgeInsets.symmetric(horizontal: 16),
                                           height: 50,
                                           decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius: BorderRadius.circular(4),
                                             border: Border.all(width: 1, color: Colors.grey.shade300),
                                           ),
                                         ),
                                         menuItemStyleData: const MenuItemStyleData(
                                           height: 40,
                                         ),
                                       ),
                                     );
                                   }
                                 }),
                                 SizedBox(height: 5,),
                                 AddProductErrorText.productCategoryError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productCategoryError.value),
                               ],
                             ),
                           ),


                           const SizedBox(width: 20,),
                           // Dropdown for selecting subcategory
                           Expanded(
                             child: Column(
                               children: [
                                 Obx(() {
                                   return _categoryController.singleSubCat.value == null
                                       ? Center()
                                       : DropdownButtonHideUnderline(
                                     child: DropdownButton2<SingleCategory>(
                                       isExpanded: true,
                                       hint: Text(
                                         'Select Main Sub Category',
                                         style: TextStyle(
                                           fontSize: 14,
                                           color: Theme.of(context).hintColor,
                                         ),
                                       ),
                                       items: _categoryController
                                           .singleMainCategory.value.subCategories!
                                           .map((item) {
                                         return DropdownMenuItem<SingleCategory>(
                                           value: item,
                                           child: Text(
                                             item.name!,
                                             style: const TextStyle(
                                               fontSize: 14,
                                             ),
                                           ),
                                         );
                                       }).toList(),
                                       value: _categoryController.singleMainCategory.value.subCategories!
                                           .contains(_categoryController.singleSubCat.value)
                                           ? _categoryController.singleSubCat.value
                                           : null, // Ensure valid value
                                       onChanged: (value) {
                                         if (value != null) {
                                           _categoryController.singleSubCat.value = value;

                                           // Add subcategory to productController's list and trigger reactivity
                                           if(controller.subCatListId.value.contains(value.id.toString()) == false){
                                             controller.subCatListId.value.add(value.id.toString());
                                             controller.subCatListId.refresh(); // Notify change

                                             controller.subCatListName.value.add(value.name.toString());
                                             controller.subCatListName.refresh(); // Notify change
                                           }


                                         }
                                       },
                                       buttonStyleData: ButtonStyleData(
                                         padding: EdgeInsets.symmetric(horizontal: 16),
                                         height: 50,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius: BorderRadius.circular(4),
                                           border: Border.all(width: 1, color: Colors.grey.shade300),
                                         ),
                                       ),
                                       menuItemStyleData: const MenuItemStyleData(
                                         height: 40,
                                       ),
                                     ),
                                   );
                                 }),
                                 SizedBox(height: 5,),
                                 AddProductErrorText.productSubCategoryError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productSubCategoryError.value),
                               ],
                             ),
                           )
                         ],
                       ),

                       SizedBox(height: 20,),
                       Obx(() {
                         return controller.subCatListName.value.isEmpty
                             ? Center()
                             : ListView.builder(
                           physics: NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: controller.subCatListName.value.length,
                           itemBuilder: (_, index) {
                             return ListTile(
                               title: Text("${controller.subCatListName.value[index]}"),
                               trailing: IconButton(
                                 onPressed: () {
                                   // Remove item from both lists and refresh
                                   controller.subCatListName.value.removeAt(index);
                                   controller.subCatListName.refresh(); // Refresh the name list


                                   controller.subCatListId.value.removeAt(index);
                                   controller.subCatListId.refresh(); // Refresh the ID list
                                 },
                                 icon: Icon(Icons.delete, color: Colors.red),
                               ),
                             );
                           },
                         );
                       }),

                     ],
                   ),
                 );
               }
             ),
           ),

         ],
       );
  }

  Column _buildMobileView(BuildContext context) {
    return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Obx((){
                             return Container(
                               height: controller.productPageMobileHeight.value,
                               padding: EdgeInsets.all(15),
                               decoration: BoxDecoration(
                                 color: AppColors.lighGry,
                                 borderRadius: BorderRadius.circular(10),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.shade300,
                                     spreadRadius: 1,
                                     blurRadius: 2,
                                     offset: const Offset(0, 0), // changes position of shadow
                                   ),
                                 ],
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("Product Details",
                                     style: formTitleStyle(),
                                   ),
                                   SizedBox(height: 20,),
                                   AppInput(text: "Product Sheet", hint: "Product Name", controller: controller.productName.value),
                                   SizedBox(height: 20,),
                                   //short description Dropdown
                                   Text("Packaging",
                                     style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   SizedBox(height: 10,),
                                   DropDown2(
                                       items: ProductJson.descriptionList,
                                       value:  controller.productShortDes.value.text.isNotEmpty ?  controller.productShortDes.value.text : null,
                                       hint: "select Packaging", onChange: (v){setState(() {
                                     controller.productShortDes.value.text = v!;
                                   });}),
                                   SizedBox(height: 5,),
                                   AddProductErrorText.productShortDescriptionError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productShortDescriptionError.value),

                                   SizedBox(height: 20,),
                                   AppInput(text: "Product Description", hint: "A details description of you product (Min 200 Characters)", maxLine: 6, controller: controller.productDes.value),
                                   SizedBox(height: 20,),
                                   AppInput(text: "Weigh in Kg, Volume inL, or unit", hint: "Unit", controller: controller.productUnit.value),
                                   SizedBox(height: 20,),
                                   Row(
                                     children: [
                                       Expanded(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text("Product Unit",
                                               style: TextStyle(
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.bold,
                                               ),
                                             ),
                                             SizedBox(height: 10,),
                                             DropDown2(
                                                 items: ProductJson.productTypeList,
                                                 hint: "Product Unit",
                                                 value: controller.productType.value.isNotEmpty ?  controller.productType.value :  null,
                                                 onChange: (v){
                                                   setState(() {
                                                     controller.productType.value = v!.toString();
                                                   });
                                                 }),
                                             SizedBox(height: 5,),
                                             AddProductErrorText.productUnitListError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productUnitListError.value),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width: 20,),
                                       Expanded(child: AppInput(text: "In Stock", hint: "1", controller: controller.productStock.value)),
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Row(
                                     children: [
                                       Expanded(
                                         child:  Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text("Origin",
                                               style: TextStyle(
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.bold,
                                               ),
                                             ),
                                             SizedBox(height: 10,),
                                             DropDown2(
                                                 items: ProductJson.allCountry,
                                                 hint: "Origin",
                                                 value: controller.country.value.isNotEmpty ?  controller.country.value :  null,
                                                 onChange: (v){
                                                   setState(() {
                                                     controller.country.value = v!.toString();
                                                   });
                                                 }),

                                             SizedBox(height: 5,),
                                             AddProductErrorText.productOriginError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productOriginError.value),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width: 20,),
                                       Expanded(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text("VAT(%)",
                                               style: TextStyle(
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.bold,
                                               ),
                                             ),
                                             SizedBox(height: 10,),
                                             Obx(() {
                                               return DropDown2(
                                                 items: controller.vatList.value,
                                                 value: controller.vatList.value.contains(controller.productTex.value.text) ? controller.productTex.value.text : null,
                                                 onChange: (v){
                                                   controller.productTex.value.text = v!;

                                                 },
                                                 hint: 'Select VAT%',

                                               );
                                             }
                                             ),
                                             SizedBox(height: 5,),
                                             AddProductErrorText.productVatError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productVatError.value),
                                           ],
                                         ),
                                       )
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Text("Product Image",
                                     style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   SizedBox(height: 10,),
                                   Row(
                                     children: [
                                       InkWell(
                                         onTap: () async {
                                           if(images.length < 5){
                                             await FirebaseImageController.startWebFilePicker(uploadImage);
                                           }else{
                                             Get.snackbar("Error!", "Max uplod 5 Image", backgroundColor: Colors.red, colorText: Colors.white);
                                           }
                                         },
                                         child: DottedBorder(
                                           borderType: BorderType.RRect,
                                           radius: Radius.circular(12),
                                           padding: EdgeInsets.all(20),
                                           child: ClipRRect(
                                             borderRadius: BorderRadius.all(Radius.circular(12)),
                                             child: Icon(Icons.upload_file_outlined, color: AppColors.primaryColor, size: 20,),
                                           ),
                                         ),
                                       ),
                                       SizedBox(width: 20,),
                                       images.isNotEmpty
                                           ? Expanded(
                                         child: GridView.builder(
                                           itemCount: images.length > 5 ? 5 : images.length,
                                           shrinkWrap: true,
                                           physics: NeverScrollableScrollPhysics(),
                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                               crossAxisCount: 5,
                                               crossAxisSpacing: 10,
                                               mainAxisSpacing: 10,
                                               mainAxisExtent: 80
                                           ),
                                           itemBuilder: (context, index){
                                             var data = images[index];
                                             return Stack(
                                               children: [
                                                 Container(
                                                   width: 100,
                                                   height: 100,
                                                   margin:
                                                   const EdgeInsets.all(10),
                                                   decoration: BoxDecoration(
                                                       borderRadius:
                                                       BorderRadius.circular(
                                                           10),
                                                       border: Border.all(
                                                           width: 1,
                                                           color: Colors.green)),
                                                   child: Image.memory(data!, fit: BoxFit.cover,),
                                                 ),
                                                 Positioned(
                                                   right: 15,
                                                   top: 15,
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Colors.white,
                                                         borderRadius:
                                                         BorderRadius.circular(
                                                             100)),
                                                     child: InkWell(
                                                         onTap: () {
                                                           setState(() {
                                                             images.removeAt(index);
                                                           });
                                                         },
                                                         child: Icon(
                                                           Icons.delete,
                                                           color: Colors.red,
                                                           size: 15,
                                                         )),
                                                   ),
                                                 )
                                               ],
                                             );
                                           },
                                         ),
                                       )
                                           :controller.productImages.value.isNotEmpty
                                           ? Expanded(
                                         child: GridView.builder(
                                           itemCount: controller.productImages.value.length ,
                                           shrinkWrap: true,
                                           physics: NeverScrollableScrollPhysics(),
                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                               crossAxisCount: 5,
                                               crossAxisSpacing: 10,
                                               mainAxisSpacing: 10,
                                               mainAxisExtent: 80
                                           ),
                                           itemBuilder: (context, index){
                                             var data = controller.productImages.value[index];
                                             return Stack(
                                               children: [
                                                 Container(
                                                   width: 100,
                                                   height: 100,
                                                   margin:
                                                   const EdgeInsets.all(10),
                                                   decoration: BoxDecoration(
                                                       borderRadius:
                                                       BorderRadius.circular(
                                                           10),
                                                       border: Border.all(
                                                           width: 1,
                                                           color: Colors.green)),
                                                   child: Image.network(data!, fit: BoxFit.cover,),
                                                 ),
                                                 Positioned(
                                                   right: 15,
                                                   top: 15,
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                         color: Colors.white,
                                                         borderRadius:
                                                         BorderRadius.circular(
                                                             100)),
                                                     child: InkWell(
                                                         onTap: () {
                                                           setState(() {
                                                             controller.productImages.value.removeAt(index);
                                                           });
                                                         },
                                                         child: Icon(
                                                           Icons.delete,
                                                           color: Colors.red,
                                                           size: 15,
                                                         )),
                                                   ),
                                                 )
                                               ],
                                             );
                                           },
                                         ),
                                       )
                                           : Center()
                                     ],
                                   ),
                                   SizedBox(height: 5,),
                                   AddProductErrorText.productImageError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productImageError.value),
                                 ],
                               ),
                             );
                           }
                         ),
                         SizedBox(height: 20,),
                         Obx(() {
                             return Container(
                               height: controller.productPageMobileHeight.value,
                               padding: EdgeInsets.all(15),
                               decoration: BoxDecoration(
                                 color: AppColors.lighGry,
                                 borderRadius: BorderRadius.circular(10),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.shade300,
                                     spreadRadius: 1,
                                     blurRadius: 2,
                                     offset: const Offset(0, 0), // changes position of shadow
                                   ),
                                 ],
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("Pricing",
                                     style: formTitleStyle(),
                                   ),
                                   SizedBox(height: 20,),
                                   AppInput(text: "Purchase Price (excle. tax)", hint: "Purchase Price (excle. tax)", controller: controller.productPurchasePrice.value,
                                     onChanged: (v){
                                       controller.restaurantPrice.value.text = ((double.parse(v) / 100) * 42 + double.parse(v)).toStringAsFixed(2);
                                       controller.resellerPrice.value.text = ((double.parse(v) / 100) * 25 + double.parse(v)).toStringAsFixed(2);
                                       controller.wholesalersPrice.value.text = ((double.parse(v) / 100) * 15 + double.parse(v)).toStringAsFixed(2);
                                     },
                                   ),
                                   SizedBox(height: 20,),
                                   Row(
                                     children: [
                                       Expanded(child: AppInput(text: "Reseller Price (+25%)", hint: "Reseller Price ", readOnly: true, controller: controller.resellerPrice.value)),
                                       SizedBox(width: 20,),
                                       Expanded(child: AppInput(text: "Restaurant Price (+42%)", hint: "Restaurant Price ",   readOnly: true, controller: controller.restaurantPrice.value)),
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Row(
                                     children: [
                                       Expanded(child: AppInput(text: "Wholesale Price (+15%)", hint: "Wholesale Price ",  readOnly: true,  controller: controller.wholesalersPrice.value)),
                                       SizedBox(width: 20,),
                                       Expanded(child: AppInput(text: "Discount (%)", hint: "Discount (%)", controller: controller.productDiscountPrice.value)),
                                     ],
                                   ),
                                   SizedBox(height: 20,),
                                   Text("Select One Or More Category",
                                     style: formTitleStyle(),
                                   ),
                                   SizedBox(height: 20,),
                                   Row(
                                     children: [
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Obx(() {
                                               // Check if mainCategoryModel.value or data is null
                                               if (_categoryController.isLoading.value) {
                                                 return Center(); // Loading state
                                               } else if (_categoryController.mainCategoryModel.value?.data == null ||
                                                   _categoryController.mainCategoryModel.value.data!.isEmpty) {
                                                 return Center(child: Text('No categories available')); // When data is empty or null
                                               } else {
                                                 return DropdownButtonHideUnderline(
                                                   child: DropdownButton2<SingleCategory>(
                                                     isExpanded: true,
                                                     hint: Text(
                                                       'Select Main Category',
                                                       style: TextStyle(
                                                         fontSize: 14,
                                                         color: Theme.of(context).hintColor,
                                                       ),
                                                     ),
                                                     items: _categoryController.mainCategoryModel.value.data!.map((item) {
                                                       return DropdownMenuItem<SingleCategory>(
                                                         value: item,
                                                         child: Text(
                                                           item.name ?? '', // Add null safety check here
                                                           style: const TextStyle(
                                                             fontSize: 14,
                                                           ),
                                                         ),
                                                       );
                                                     }).toList(),
                                                     value: _categoryController.mainCategoryModel.value.data!
                                                         .contains(_categoryController.singleMainCategory.value)
                                                         ? _categoryController.singleMainCategory.value
                                                         : null, // Ensure a valid value is selected
                                                     onChanged: (value) {
                                                       if (value != null) {
                                                         _categoryController.singleMainCategory.value = value;
                                                         _categoryController.subCatList.value = value.subCategories ?? [];
                                                         controller.mainCatId.value = value.id.toString();
                                                       }
                                                     },
                                                     buttonStyleData: ButtonStyleData(
                                                       padding: EdgeInsets.symmetric(horizontal: 16),
                                                       height: 50,
                                                       decoration: BoxDecoration(
                                                         color: Colors.white,
                                                         borderRadius: BorderRadius.circular(4),
                                                         border: Border.all(width: 1, color: Colors.grey.shade300),
                                                       ),
                                                     ),
                                                     menuItemStyleData: const MenuItemStyleData(
                                                       height: 40,
                                                     ),
                                                   ),
                                                 );
                                               }
                                             }),
                                             SizedBox(height: 5,),
                                             AddProductErrorText.productCategoryError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productCategoryError.value),
                                           ],
                                         ),
                                       ),


                                       const SizedBox(width: 20,),
                                       // Dropdown for selecting subcategory
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Obx(() {
                                               return _categoryController.singleSubCat.value == null
                                                   ? Center()
                                                   : DropdownButtonHideUnderline(
                                                 child: DropdownButton2<SingleCategory>(
                                                   isExpanded: true,
                                                   hint: Text(
                                                     'Select Main Sub Category',
                                                     style: TextStyle(
                                                       fontSize: 14,
                                                       color: Theme.of(context).hintColor,
                                                     ),
                                                   ),
                                                   items: _categoryController
                                                       .singleMainCategory.value.subCategories!
                                                       .map((item) {
                                                     return DropdownMenuItem<SingleCategory>(
                                                       value: item,
                                                       child: Text(
                                                         item.name!,
                                                         style: const TextStyle(
                                                           fontSize: 14,
                                                         ),
                                                       ),
                                                     );
                                                   }).toList(),
                                                   value: _categoryController.singleMainCategory.value.subCategories!
                                                       .contains(_categoryController.singleSubCat.value)
                                                       ? _categoryController.singleSubCat.value
                                                       : null, // Ensure valid value
                                                   onChanged: (value) {
                                                     if (value != null) {
                                                       _categoryController.singleSubCat.value = value;

                                                       // Add subcategory to productController's list and trigger reactivity
                                                       if(controller.subCatListId.value.contains(value.id.toString()) == false){
                                                         controller.subCatListId.value.add(value.id.toString());
                                                         controller.subCatListId.refresh(); // Notify change

                                                         controller.subCatListName.value.add(value.name.toString());
                                                         controller.subCatListName.refresh(); // Notify change
                                                       }


                                                     }
                                                   },
                                                   buttonStyleData: ButtonStyleData(
                                                     padding: EdgeInsets.symmetric(horizontal: 16),
                                                     height: 50,
                                                     decoration: BoxDecoration(
                                                       color: Colors.white,
                                                       borderRadius: BorderRadius.circular(4),
                                                       border: Border.all(width: 1, color: Colors.grey.shade300),
                                                     ),
                                                   ),
                                                   menuItemStyleData: const MenuItemStyleData(
                                                     height: 40,
                                                   ),
                                                 ),
                                               );
                                             }),
                                             SizedBox(height: 5,),
                                             AddProductErrorText.productSubCategoryError.value.isEmpty ? Center() : ErrorText(text: AddProductErrorText.productSubCategoryError.value),
                                           ],
                                         ),
                                       )
                                     ],
                                   ),

                                   SizedBox(height: 20,),
                                   Obx(() {
                                     return controller.subCatListName.value.isEmpty
                                         ? Center()
                                         : ListView.builder(
                                       physics: NeverScrollableScrollPhysics(),
                                       shrinkWrap: true,
                                       itemCount: controller.subCatListName.value.length,
                                       itemBuilder: (_, index) {
                                         return ListTile(
                                           title: Text("${controller.subCatListName.value[index]}"),
                                           trailing: IconButton(
                                             onPressed: () {
                                               // Remove item from both lists and refresh
                                               controller.subCatListName.value.removeAt(index);
                                               controller.subCatListName.refresh(); // Refresh the name list


                                               controller.subCatListId.value.removeAt(index);
                                               controller.subCatListId.refresh(); // Refresh the ID list
                                             },
                                             icon: Icon(Icons.delete, color: Colors.red),
                                           ),
                                         );
                                       },
                                     );
                                   }),

                                 ],
                               ),
                             );
                           }
                         ),

                       ],
                     );
  }
}

