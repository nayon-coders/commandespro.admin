import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/products/controller/category.controller.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_network_image.dart';
import '../../../controller/firebase.image.controller.dart';
import '../../../data/model/main.category.model.dart';
import '../../../comman/app_input.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final CategoryController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Container(
            padding: isMobile ? EdgeInsets.all(15) : EdgeInsets.only(left: 100, right: 100, top: 50, bottom: 50),
            child: Builder(

              builder: (context) {
                if(isMobile){
                  return  _buildMobileView(context);
                }else{
                  return _buildWebView(context);
                }

              }
            ),
          );
        }
      ),
    );
  }

  Row _buildWebView(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // left side  menus
                    Expanded(
                      child: AddMainCategporyWidgets(controller: controller),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        height: 430,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 3,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add a New Sub Category",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            SizedBox(height: 30,),
                            Center(
                              child: InkWell(
                                onTap: ()async{
                                  await FirebaseImageController.startWebFilePicker(controller.subCategoryCallBack);
                                },
                                child: Obx(() {
                                  return DottedBorder(
                                    borderPadding: EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Center(
                                        child: controller.subCatImage.value != null ? Image.memory(controller.subCatImage.value!) :  Icon(Icons.upload_outlined, color: Colors.grey, size: 30,),
                                      ),
                                    ),
                                  );
                                }
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            AppInput(
                              text: "",
                              hint: "Sub Category Name",
                              isValidatorNeed: true,
                              controller: controller.subCategoryName.value,
                            ),
                            SizedBox(height: 20,),
                            Obx(() {
                              // Check if mainCategoryModel.value or data is null
                              if (controller.isLoading.value) {
                                return Center(); // Loading state
                              } else if (controller.mainCategoryModel.value?.data == null ||
                                  controller.mainCategoryModel.value.data!.isEmpty) {
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
                                    items: controller.mainCategoryModel.value.data!.map((item) {
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
                                    value: controller.mainCategoryModel.value.data!
                                        .contains(controller.singleMainCategory.value)
                                        ? controller.singleMainCategory.value
                                        : null, // Ensure a valid value is selected
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.singleMainCategory.value = value;
                                        controller.subCatList.value = value.subCategories ?? [];
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
                            SizedBox(height: 20,),
                            Obx(() {
                              return AppButton(
                                isLoading: controller.isAddingSubCat.value,
                                width: Get.width,
                                onClick: (){
                                  if(controller.subCategoryName.value.text.isNotEmpty){
                                    controller.addSubCategory(9);
                                  }
                                },
                                text: "Add New Sub Category",
                              );
                            }
                            )

                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        height: 430,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 3,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("All Categories",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            SizedBox(height: 10,),
                            GetAllCategory(
                              controller: controller,
                            )

                          ],
                        ),
                      ),
                    ),

                  ],
                );
  }

  Column _buildMobileView(BuildContext context) {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // left side  menus
                    AddMainCategporyWidgets(controller: controller),
                    SizedBox(height: 20,),
                    Container(
                      height: 430,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add a New Sub Category",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: InkWell(
                              onTap: ()async{
                                await FirebaseImageController.startWebFilePicker(controller.subCategoryCallBack);
                              },
                              child: Obx(() {
                                return DottedBorder(
                                  borderPadding: EdgeInsets.all(10),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Center(
                                      child: controller.subCatImage.value != null ? Image.memory(controller.subCatImage.value!) :  Icon(Icons.upload_outlined, color: Colors.grey, size: 30,),
                                    ),
                                  ),
                                );
                              }
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          AppInput(
                            text: "",
                            hint: "Sub Category Name",
                            isValidatorNeed: true,
                            controller: controller.subCategoryName.value,
                          ),
                          SizedBox(height: 20,),
                          Obx(() {
                            // Check if mainCategoryModel.value or data is null
                            if (controller.isLoading.value) {
                              return Center(); // Loading state
                            } else if (controller.mainCategoryModel.value?.data == null ||
                                controller.mainCategoryModel.value.data!.isEmpty) {
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
                                  items: controller.mainCategoryModel.value.data!.map((item) {
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
                                  value: controller.mainCategoryModel.value.data!
                                      .contains(controller.singleMainCategory.value)
                                      ? controller.singleMainCategory.value
                                      : null, // Ensure a valid value is selected
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.singleMainCategory.value = value;
                                      controller.subCatList.value = value.subCategories ?? [];
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
                          SizedBox(height: 20,),
                          Obx(() {
                            return AppButton(
                              isLoading: controller.isAddingSubCat.value,
                              width: Get.width,
                              onClick: (){
                                if(controller.subCategoryName.value.text.isNotEmpty){
                                  controller.addSubCategory(9);
                                }
                              },
                              text: "Add New Sub Category",
                            );
                          }
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 500,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("All Categories",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          SizedBox(height: 10,),
                          GetAllCategory(
                            controller: controller,
                          )

                        ],
                      ),
                    ),

                  ],
                );
  }
}

class AddMainCategporyWidgets extends StatelessWidget {
  const AddMainCategporyWidgets({
    super.key,
    required this.controller,
  });

  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Container(
          height: 430,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                spreadRadius: 1,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add a New Category",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w900
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: InkWell(
                  onTap: ()async{
                    await FirebaseImageController.startWebFilePicker(controller.categoryCallBack);
                  },
                  child: DottedBorder(
                    borderPadding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child:  Center(
                            child:  controller.mainCatImage.value != null
                            ? Image.memory(
                            controller.mainCatImage!.value!, width: 100, height: 100,
                              fit: BoxFit.cover,
                            ) : controller.editSingleCategory.value?.image != null
                          ? AppNetworkImage(image: controller.editSingleCategory.value!.image!,  width: 100, height: 100, )
                                : Icon(Icons.upload_outlined, color: Colors.grey, size: 30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              AppInput(
                text: "",
                hint: "Category Name",
                isValidatorNeed: true,
                controller: controller.categoryName.value,
              ),
              SizedBox(height: 20,),
              Obx((){
                  return AppButton(
                    isLoading: controller.isLoading.value,
                    width: Get.width,
                      onClick: (){
                          if(controller.categoryName.value.text.isNotEmpty){
                            if(controller.editSingleCategory.value?.image != null){
                              controller.updateCategory();
                            }else{
                              controller.createCategory();
                            }
                          }
                      },
                      text: "Add Category",
                  );
                }
              )

            ],
          ),
        );
      }
    );
  }
}

class GetAllCategory extends StatelessWidget {
  const GetAllCategory({
    super.key, required this.controller,
  });

  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Obx(() {
        if(controller.isDataGetting.value){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            itemCount: controller.mainCategoryModel.value.data!.length,
            itemBuilder: (_, index){
              var data = controller.mainCategoryModel.value.data![index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppNetworkImage(image: data.image!, height: 30, width: 30,),
                            SizedBox(width: 10,),
                            Text("${data.name}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                controller.editSingleCategory.value = data!;
                                controller.categoryName.value.text = data.name!;
                                controller.selectedId.value = data.id.toString();
                              },
                              icon: Icon(Icons.edit, color: Colors.blue, size: 20,),
                            ),
                            IconButton(
                              onPressed: (){
                                Get.defaultDialog(
                                    title: "Are You sure?",
                                    content: Container(
                                      width: 400,
                                      padding: const EdgeInsets.all(12.0),
                                      child: const Text(
                                          "Do you want to delete this category? If you delete the category, all subcategories will be deleted and also all products under this category will be deleted."),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors
                                                    .black),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            Get.back();
                                            await controller
                                                .deleteMainCategory(
                                                data.id
                                                    .toString());

                                          },
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Colors
                                                    .red),
                                          )),
                                    ]
                                );
                              },
                              icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  data.subCategories!.isEmpty ? Center() : SizedBox(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.subCategories!.length,
                        itemBuilder: (context, subIndex) {
                          var subCat = data.subCategories![subIndex];
                          return  Container(
                            height: 30,
                            margin: const EdgeInsets.only(
                                left: 40, bottom: 5),
                            padding: const EdgeInsets.only(
                                left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AppNetworkImage(image: subCat.image!, height: 30, width: 30,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${subCat.name}",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                title: "Are You sure?",
                                                content: const Text(
                                                    "Do you want to delete this category?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black),
                                                      )),
                                                  TextButton(
                                                      onPressed: () async {
                                                        Get.back();
                                                        await controller
                                                            .deleteSubCategory(
                                                            subCat.id
                                                                .toString());

                                                      },
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red),
                                                      )),
                                                ]
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            },
          );
        }

        }
      ),
    );
  }
}
