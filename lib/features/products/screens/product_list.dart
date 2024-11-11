import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../comman/app_table/app.table.dart';
import '../../../comman/app_table/table.header.dart';
import '../../../routes/app_pages.dart';
import '../controller/product_controller.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductController _productController = Get.find();

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
        padding: EdgeInsets.all(50),
        child: AppTable(
          title: "Product List",
          headersChildren:const [
            TableHeader(name: "ID", width: 50),
            TableHeader(name: "Name", width: 200),
            TableHeader(name: "Stock", width: 80),
            TableHeader(name: "Purchase Price", width: 100),
            TableHeader(name: "Retailer Price", width: 100),
            TableHeader(name: "Whole Sell", width: 90),
            TableHeader(name: "Seller Price", width: 90),
            TableHeader(name: "Status", width: 80),
            TableHeader(name: "Date", width: 90),
            TableHeader(name: "Action", width: 140),
          ],
          row:  Obx(() {
            if(_productController.isGettingData.value){
              return Center(child: CircularProgressIndicator());
            }else{
              if(_productController.productListModel.value.data!.isEmpty ){
                return Center(child: Text("No product found!"),);
              }else {
                //if data
                if(_productController.searchResults.isNotEmpty){
                  return Obx((){
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //data length
                      itemCount: _productController.searchResults!.length,
                      itemBuilder: (context, index){


                        var data = _productController.searchResults![index];

                        //store data variable
                        return Container(
                          height: 56,
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
                              TableHeader(name:"${index+1}", width: 50),


                              //Name
                              TableHeader(name: "${data.name}", width: 200),



                              //Stock
                              TableHeader(name: "${data.isStock}", width: 80),


                              //Purchase Price
                              TableHeader(name: "${data.purchasePrice}", width: 100),



                              //Retailer Price
                              TableHeader(name: "${data.regularPrice}", width: 100),




                              //Whole Sell
                              TableHeader(name: "${data.wholePrice}", width: 90),



                              //Seller Price
                              TableHeader(name: "${data.sellingPrice}", width: 90),

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


                              //DateTime
                              TableHeader(name: "${DateFormat("dd/mm/yyyy").format(DateTime.now())}", width: 90),


                              //Action button
                              SizedBox(
                                width: 140,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: (){
                                            _productController.selectedSingleProductListModel.value = data;
                                            _productController.updateProductValue();
                                            Get.toNamed(AppRoute.add_new_product);
                                            print("Edit");

                                          },
                                          icon:const Icon(Icons.edit,color: Colors.amber,)
                                      ),
                                      Obx(() {
                                        return IconButton(
                                            onPressed: (){
                                              _productController.selectedSingleProductListModel.value = data;
                                              _productController.updateProductValue();
                                            },
                                            icon: _productController.isDeletingData.value ? Center(child: CircularProgressIndicator(),) : Icon(Icons.visibility,color: Colors.green,));
                                      }
                                      ),
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
                                      ),                                ],
                                  ),
                                ),
                              ),










                            ],
                          ),
                        );
                      },
                    );
                  }
                  );
                }else{
                  return ListView.builder(
                    //data length
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _productController.productListModel.value.data!.length,
                    itemBuilder: (context, index){


                      var data = _productController.productListModel.value!.data![index];

                      //store data variable
                      return Container(
                        height: 56,
                      //  margin:const EdgeInsets.only(bottom:5,top: 5),
                        padding:const EdgeInsets.only(left: 15, right: 15,bottom: 5,top: 5),
                        decoration: BoxDecoration(
                          color:index.isEven ?Colors.white :Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [



                            //Id
                            TableHeader(name:"${index+1}", width: 50),


                            //Name
                            TableHeader(name: "${data.name}", width: 200),



                            //Stock
                            TableHeader(name: "${data.isStock}", width: 80),


                            //Purchase Price
                            TableHeader(name: "${data.purchasePrice}", width: 100),



                            //Retailer Price
                            TableHeader(name: "${data.regularPrice}", width: 100),




                            //Whole Sell
                            TableHeader(name: "${data.wholePrice}", width: 90),



                            //Seller Price
                            TableHeader(name: "${data.sellingPrice}", width: 90),

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


                            //DateTime
                            TableHeader(name: "${DateFormat("dd/mm/yyyy").format(DateTime.now())}", width: 90),


                            //Action button
                            SizedBox(
                              width: 140,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                          _productController.selectedSingleProductListModel.value = data;
                                          _productController.updateProductValue();
                                          Get.toNamed(AppRoute.add_new_product);
                                          print("Edit");

                                        },
                                        icon:const Icon(Icons.edit,color: Colors.amber,)
                                    ),
                                    Obx(() {
                                      return IconButton(
                                          onPressed: (){
                                            _productController.selectedSingleProductListModel.value = data;
                                            _productController.updateProductValue();
                                          },
                                          icon: _productController.isDeletingData.value ? Center(child: CircularProgressIndicator(),) : Icon(Icons.visibility,color: Colors.green,));
                                    }
                                    ),
                                    Obx(() {
                                      return IconButton(
                                          onPressed: (){
                                            Get.defaultDialog(
                                                title: "Are you sure?",
                                                content: Text("Do you want to delete product?"),
                                                onConfirm: (){
                                                  return  _productController.isDeletingData.value ? null :  _productController.deleteProduct(data.id.toString());
                                                },
                                            );
                                          },
                                          icon: _productController.isDeletingData.value ? Center(child: CircularProgressIndicator(),) : Icon(Icons.delete,color: Colors.red,));
                                    }
                                    ),                                ],
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
