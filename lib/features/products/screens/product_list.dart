import 'package:commandespro_admin/comman/app_input.dart';
import 'package:commandespro_admin/features/ajouter_cmd/widget/input_filed.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/settings/controller/admin.role.controller.dart';
import 'package:commandespro_admin/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../comman/app_table/app.table.dart';
import '../../../comman/app_table/table.header.dart';
import '../../../comman/dropdown2.dart';
import '../../../controller/product_json.dart';
import '../../../data/model/product.list.model.dart';
import '../../../routes/app_pages.dart';
import '../controller/product_controller.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductController _productController = Get.find();
  final AdminRoleController adminRoleController = Get.find();

  final _searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productController.getAllProduct();
    });

  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: AppTable(
          title: "Product List",
          isShowAddButton: true,
          buttonText: "Add New Product",
          onAddButton: (){
            Get.toNamed(AppRoute.add_new_product);
          },
          headersChildren:const [
            TableHeader(name: "REF", width: 30),
            TableHeader(name: "PRODUCTS", width: 200),
            TableHeader(name: "PURCHASE PRICE ", width: 140),
            TableHeader(name: "UNITS", width: 150),
            TableHeader(name: "UV", width: 60),
            TableHeader(name: "STOCK", width: 80),
            TableHeader(name: "ORIGIN", width: 200),
            TableHeader(name: "STATUS", width: 80),
            TableHeader(name: "Action", width: 100),
          ],
          row:  Obx(() {
            if(_productController.singleProductsList.isEmpty ){
              if(_productController.isGettingData.value) {
                return Center(child: CircularProgressIndicator(),);
              }else{
                return Center(child: Text("No product found!"),);
              }
            }else {
              //if data
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //data length
                itemCount: _productController.singleProductsList.length,
                itemBuilder: (context, index){


                  SingleProducts data =  _productController.singleProductsList[index];

                  //store data variable
                  return Container(
                    height: 45,
                    //margin:const EdgeInsets.only(bottom:5,top: 5),
                    padding:const EdgeInsets.only(left: 15, right: 15,bottom: 5,top: 5),
                    decoration: BoxDecoration(
                      color:index.isEven ?Colors.white : Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Id
                        Container(
                          width: 30,
                          padding: EdgeInsets.all(6),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text("${index+1}"),
                        ),
                        //Name
                        Container(
                          width: 200,
                          padding: EdgeInsets.all(6),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: InputFiled(
                              hint: "Name",
                              controller: _productController.productNameList.value[index],
                            onChanged: (v){
                              _productController.editProductList(data.id.toString(), index);
                            },
                          )
                        ),
                        //Stock
                        Container(
                            width: 140,
                            padding: EdgeInsets.all(6),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: InputFiled(
                                onChanged: (v){
                                  _productController.editProductList(data.id.toString(), index);
                                },
                                hint: "Purchases price",
                                controller: _productController.productPurchasePriceList.value[index]
                            )
                        ),
                        Container(
                            width: 150,
                            padding: EdgeInsets.all(6),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: DropDown2(
                                items: ProductJson.productTypeList,
                                hint: "Unit",
                                value: _productController.productTypesList.value[index].text.isNotEmpty ?  _productController.productTypesList.value[index].text :  null,
                                onChange: (v){
                                  setState(() {
                                    _productController.productTypesList.value[index].text = v!.toString();
                                  });
                                    _productController.editProductList(data.id.toString(), index);
                                }),
                        ),
                        Container(
                            width: 60,
                            padding: EdgeInsets.all(6),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: InputFiled(
                                hint: "UV",
                                controller: _productController.units.value[index],
                              onChanged: (v){
                                _productController.editProductList(data.id.toString(), index);
                              },
                            )
                        ),
                        Container(
                            width: 80,
                            padding: EdgeInsets.all(6),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: InputFiled(
                                hint: "Stock",
                                controller: _productController.stock.value[index],
                              onChanged: (v){
                                _productController.editProductList(data.id.toString(), index);
                              },
                            )
                        ),
                        Container(
                            width: 200,
                            padding: EdgeInsets.all(6),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child:  DropDown2(
                                items: ProductJson.allCountry,
                                hint: "Origin",
                                value: _productController.origin.value[index].text!.isNotEmpty ?  _productController.origin.value[index].text :  null,
                                onChange: (v){
                                  setState(() {
                                    _productController.origin.value[index].text = v!.toString();
                                  });
                                    _productController.editProductList(data.id.toString(), index);
                                }),
                        ),
                        //Status
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            color: data.status!.toLowerCase() == "active" ? Colors.green.shade200 :  Colors.red.shade200,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text("Active",style: TextStyle(color: data.status!.toLowerCase() == "active" ? Colors.green : Colors.red),),
                          ),
                        ),
                        //Action button
                        SizedBox(
                          width: 120,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return IconButton(
                                      onPressed: (){
                                        _productController.editProductList(data.id.toString(), index, isFromClick: true);
                                      },
                                      icon: _productController.isDeletingData.value ? Center(child: CircularProgressIndicator(),) : Icon(Icons.save,color: Colors.green,));
                                }
                                ),
                                IconButton(
                                    onPressed: (){
                                      _productController.selectedSingleProductListModel.value = data;
                                      _productController.updateProductValue();
                                      Get.toNamed(AppRoute.add_new_product);
                                      print("Edit");

                                    },
                                    icon:const Icon(Icons.edit,color: Colors.amber,)
                                ),
                                // Obx(() {
                                //   return IconButton(
                                //       onPressed: (){
                                //         _productController.selectedSingleProductListModel.value = data;
                                //         _productController.updateProductValue();
                                //       },
                                //       icon: _productController.isDeletingData.value ? Center(child: CircularProgressIndicator(),) : Icon(Icons.visibility,color: Colors.green,));
                                // }
                                // ),
                                Obx(() {
                                  return IconButton(
                                      onPressed: (){
                                        Get.defaultDialog(
                                            title: "Are you sure?",
                                            content: Text("Do you want to delete product?"),
                                            onConfirm: (){
                                              return  _productController.isDeletingData.value ? null :  _productController.deleteProduct(data.id.toString());
                                            },
                                            onCancel: ()=>Get.back()
                                        );
                                      },
                                      icon: _productController.isDeletingData.value ? Center(child: CircularProgressIndicator(),) : Icon(Icons.delete,color: Colors.red,));
                                }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

          }
          ) ,
          onSearch: (){
            _productController.searchOrderByCompanyName(_searchController.text);
            setState(() {

            });
          },
          onChanged: (v){
            _productController.searchOrderByCompanyName(v.toString());
            setState(() {

            });
          },
          searchController: _searchController,

        ),

      ),
    );
  }
}
