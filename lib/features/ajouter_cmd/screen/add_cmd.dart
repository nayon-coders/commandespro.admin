

import 'package:commandespro_admin/comman/app_input.dart';
import 'package:commandespro_admin/comman/dropdown2.dart';
import 'package:commandespro_admin/controller/date_picker.dart';
import 'package:commandespro_admin/features/ajouter_cmd/controller/controller.dart';
import 'package:commandespro_admin/features/ajouter_cmd/widget/input_filed.dart';
import 'package:commandespro_admin/features/ajouter_cmd/widget/selecte_delivery_address.dart';
import 'package:commandespro_admin/features/customers_screen/controller/user.controller.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/products/controller/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/AppButton.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';
import '../widget/select_customer.dart';
import '../widget/select_product.dart';
import '../widget/vta_list_tile.dart';

class AddCmd extends StatefulWidget {
  const AddCmd({super.key});

  @override
  State<AddCmd> createState() => _AddCmdState();
}

class _AddCmdState extends State<AddCmd> {
  final CMDController controller = Get.find<CMDController>();
  final AppUserController customerController = Get.put(AppUserController());
  final ProductController productController = Get.find();
  final DatePickerController datatimeController = Get.put(DatePickerController());
 
  final _productNumber = TextEditingController();
  final _vat = TextEditingController();
  final _quantity= TextEditingController();
  final _priceVat = TextEditingController();
  final _totalVat = TextEditingController();
  final _description = TextEditingController();

  String? selectedValue;
  String? selectStatus;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{

       customerController.getAllUser("");
      var data = await productController.getAllProduct();
       controller.selectedProduct.value = data!.first;
       controller.quantity.value[0].text = "1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body:Container(
          width: Get.width,
          padding:const EdgeInsets.only(left: 200, right: 200, top: 40, bottom: 50),
          child: Column(
            children: [
              Container(
                padding:const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    Center(
                      child: Text("Add an Order",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                          color: AppColors.primaryColor
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                  //Customer name
                    SelectCustomer(customerController: customerController, controller: controller), //Select Customer


                    SelectDeliveryAddress(customerController: customerController, controller: controller), //Select Customer
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delivery Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16
                                ),
                              ),
                              SizedBox(height: 10,),
                              Obx(() {
                                  return InkWell(
                                    onTap: (){
                                      datatimeController.pickDate(context);
                                      controller.deliveryDate.value = datatimeController.formattedDateForServer.value;
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text("${controller.deliveryDate.value}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ],
                          )
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Payment Method",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Obx(() {
                                  return InkWell(
                                    onTap: (){
                                      datatimeController.pickDate(context);
                                      controller.deliveryDate.value = datatimeController.formattedDate.value;
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: DropDown2(
                                          items: controller.paymentMethodList.value,
                                          hint: "Select payment mthod",
                                          onChange: (v){
                                            controller.paymentMethod.value = v;
                                          }
                                      ),
                                    ),
                                  );
                                }
                                ),
                              ],
                            )
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),
                    SelectProduct(productController: productController, controller: controller),

                    const SizedBox(height: 20,),

                    Obx(() {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _tableHeader(),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.selectedProductList.length,
                              itemBuilder: (_, index){
                                print("controller.quantity.value: ${controller.quantity.value.length}");

                                var data = controller.selectedProductList[index];
                                return Container(
                                  width: Get.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: index.isEven ? Colors.grey.shade100 : Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Image.network("${data.images![0].imageUrl}",width: 30,height: 30,),
                                            Text("${data.name}",style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: Center(
                                          child: InputFiled(
                                            controller: controller.quantity[index], hint: 'Quantity',
                                            onChanged: (v){
                                             print(" controller.quantity[index].text --- ${ controller.quantity[index].text}");
                                              controller.totalPriceCalculation(index);
                                              // controller.totalTaxCalculation();
                                              // controller.totalDiscountCalculation();
                                              // controller.totalAmountCalculation();
                                              // controller.subTotalCalculation();

                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: Center(
                                          child: InputFiled(
                                            controller: controller.comment.value[index], hint: 'Comment',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: Obx(() {
                                            return Center(
                                              child: Text("${controller.totalProductPrice.value[index].toStringAsFixed(2)} €",style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),),
                                            );
                                          }
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("${data.tax} %",style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        child: Obx(() {
                                            return Center(
                                              child: Text("${controller.totalProductPriceWithTax.value[index].toStringAsFixed(2)} €",style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),),
                                            );
                                          }
                                        ),
                                      ),
                                      Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right:BorderSide(color: Colors.white),
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: (){
                                              controller.selectedProductList.removeAt(index);
                                              controller.quantity.removeAt(index);
                                              controller.comment.removeAt(index);
                                              controller.totalProductPrice.removeAt(index);

                                              controller.totalTaxCalculation();
                                              controller.totalDiscountCalculation();
                                              controller.totalAmountCalculation();
                                              controller.subTotalCalculation();
                                            },
                                            icon: Icon(Icons.delete,color: Colors.red,),
                                          )
                                      ),


                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      }
                    ),
                    const SizedBox(height: 20,),

                    const SizedBox(height: 20,),

                    SizedBox(height: 30,),

                    //Postal List Table
                    Obx(() {
                        return VtaListTile(title: "Sous-total HT :", amount: "${controller.subTotal.value.toStringAsFixed(2)} €",);
                      }
                    ),
                    SizedBox(height: 20,),
                    Obx(() {
                        return VtaListTile(title: "TVA :",  amount: "${controller.totalTax.value.toStringAsFixed(2)} €");
                      }
                    ),
                    SizedBox(height: 20,),
                    Obx(() {
                        return VtaListTile(title: "TVA(%) :",  amount: "${controller.totalTaxRate.value.toStringAsFixed(2)} %");
                      }
                    ),
                    SizedBox(height: 20,),
                    Obx(() {
                        return VtaListTile(title: "Delivery Fee:",  amount: "${controller.deliveryCost.value.toStringAsFixed(2)} €");
                      }
                    ),
                    SizedBox(height: 20,),
                    // VtaListTile(title: "TVA (5,5%) :",),
                    // SizedBox(height: 20,),
                    Obx(() {
                        return VtaListTile(title: "Total TTC :",  amount: "${controller.totalAmount.value.toStringAsFixed(2)}  €");
                      }
                    ),
                    SizedBox(height: 30,),
                    Obx(() {
                        return AppButton(
                          isLoading: controller.isOrderCreating.value,
                          width: 200,
                            onClick: (){
                              if(controller.selectedUser.value == null){
                                Get.snackbar("Error!", "Please select a customer", backgroundColor: Colors.red);
                                return;
                              }
                              if(controller.selectedDeliveryAddress.value == null){
                                Get.snackbar("Error!", "Please select a delivery address", backgroundColor: Colors.red);
                                return;
                              }
                              if(controller.selectedProductList.isEmpty){
                                Get.snackbar("Error!", "Please select a product", backgroundColor: Colors.red);
                                return;
                              }
                              controller.createOrder();

                            },
                            text: "Enregisrer la Commande"
                        );
                      }
                    )




                  ],
                ),
              ),



            ],
          ),
        ),
    );
  }

  Container _tableHeader() {
    return Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("Product Name",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("Quantity",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("Comment",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("Unit Price excluding VAT	",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                             Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("VAT (%)",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("Total excluding VAT",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Center(
                                child: Text("Action",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),


                          ],
                        ),
                      );
  }
}

