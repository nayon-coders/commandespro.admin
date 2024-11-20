
import 'package:commandespro_admin/controller/date_picker.dart';
import 'package:commandespro_admin/features/auth/controller/auth_controller.dart';
import 'package:commandespro_admin/features/customers_screen/controller/user.controller.dart';
import 'package:commandespro_admin/features/invoice/widgets/filter_options_view.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/order/controller/print_controller.dart';
import 'package:commandespro_admin/routes/open_ne_tab_rout.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../comman/app_input.dart';
import '../../../comman/app_table/app.table.dart';
import '../../../comman/app_table/table.header.dart';
import '../controller/controller.dart';
class InvoiceGanerate extends StatefulWidget {
  const InvoiceGanerate({super.key});

  @override
  State<InvoiceGanerate> createState() => _InvoiceGanerateState();
}

class _InvoiceGanerateState extends State<InvoiceGanerate> {
  final InvoiceController controller = Get.find();
  final DatePickerController datePickerController = Get.find();
  final PrintController printController = Get.put(PrintController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.getMyProfile();

  }
  @override
  Widget build(BuildContext context) {

    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTab = ResponsiveBreakpoints.of(context).isTablet;


    return AppScaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: isMobile || isTab ? EdgeInsets.all(15) : EdgeInsets.only(left: 100, right: 100, top: 50,bottom: 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Invoice Generator",
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.primaryColor
                ),),
            ),
            SizedBox(height: 20,),
            FilterOptionsView(),
            SizedBox(height: 30,),
            Obx(() {
              if(controller.shortOrderList.isEmpty){
                return Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 100),
                    child: Center(child: Text("Generate Invoice",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.primaryColor
                      ),)
                    ));
              }else{
                return AppTable(
                  isSearchShow: false,
                  //pageLength: controller.allOrderModel.value.totalOrders!,
                  title: "All Order's",
                  headersChildren: [
                    TableHeader(name: "ID", width: 50),
                    TableHeader(name: "Reference", width: 100),
                    TableHeader(name: "Customer", width: 100),
                    TableHeader(name: "Invoice date", width: 130),
                    TableHeader(name: "Amount excluding VAT	", width: 200),
                    TableHeader(name: "Amount including tax	", width: 200),
                    TableHeader(name: "ACTIONS", width: 100),
                    // SizedBox(
                    //   width: 130,
                    //   child: Row(
                    //     children: [
                    //       TableHeader(name: "SELECTION", width: 90),
                    //       Obx(() {
                    //         return Checkbox(
                    //           value: controller.isAllSelectedOrder.value,
                    //           onChanged: (bool? value) {
                    //             print("the value  is --- ${value}");
                    //             controller.isAllSelectedOrder.value = value!;
                    //             if(value){
                    //               if(controller.shortOrderList.value.isEmpty){
                    //                 controller.selectedOrdersItems.value = controller.shortOrderList.value!;
                    //               }else{
                    //                 controller.selectedOrdersItems.value = controller.shortOrderList.value;
                    //               }
                    //             }else{
                    //               controller.selectedOrdersItems.value = [];
                    //             }
                    //           },
                    //
                    //         );
                    //       }
                    //       ),
                    //     ],
                    //   ),
                    // ),

                  ],
                  row: Container(
                    child: Obx(() {
                      return ListView.builder(
                        //data length
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.shortOrderList?.length,
                        itemBuilder: (context, index){
                          //store data variable
                          var data =  controller.shortOrderList![index] ;
                          return Container(
                            //margin:const EdgeInsets.only(bottom:5,top: 5),
                            padding:const EdgeInsets.only(left: 5, right: 5, bottom: 5,top: 5),
                            decoration: BoxDecoration(
                              color:index.isEven?Colors.grey.shade100: Colors.grey.shade50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Id
                                Container(
                                  width: 40,
                                    height: 40,
                                    padding: EdgeInsets.only(left: 10,right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TableHeader(name: "${index+1}", width: 100)
                                ),

                                Center(
                                  child: Container(
                                    transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                                    width: 100,
                                    child: AppInput(
                                      hint: "INV-00${index+1}",
                                      controller: controller.invoiceTextEditingControllerList[index],
                                      text: "",
                                    ),
                                  ),
                                ),

                                Container(
                                    width: 100,
                                    height: 40,
                                    padding: EdgeInsets.only(left: 10,right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TableHeader(name: "${data.company}", width: 100)
                                ),

                                Obx(() {
                                    return InkWell(
                                      onTap: (){
                                        datePickerController.pickDate(context);
                                        controller.invoiceDateList.value.insert(index,  datePickerController.formattedDate.value);

                                        print("controller.invoiceDateList ----- ${controller.invoiceDateList[index]}");
                                      },
                                      child: Container(
                                          width: 130,
                                          height: 40,
                                          padding: EdgeInsets.only(left: 10,right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: TableHeader(name: "${controller.invoiceDateList.value[index]}", width: 100)
                                      ),
                                    );
                                  }
                                ),

                                Container(
                                    width: 200,
                                    height: 40,
                                    padding: EdgeInsets.only(left: 10,right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TableHeader(name: "${controller.invoiceTotalOrderAmount} €", width: 100)
                                ),

                                Container(
                                    width: 200,
                                    height: 40,
                                    padding: EdgeInsets.only(left: 10,right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TableHeader(name: "${controller.invoiceTotalOrderAmountWithTax} €", width: 100)
                                ),


                                Container(
                                  width: 40,
                                  height: 40,
                                //  padding: EdgeInsets.only(left: 10,right: 5),
                                  margin: EdgeInsets.only(right: 60),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: [
                                      Obx(() {
                                          return IconButton(
                                              onPressed: ()async{
                                                if(controller.invoiceTextEditingControllerList[index].text.isEmpty){
                                                  Get.snackbar("Error!", "Please enter invoice number", backgroundColor: Colors.red);
                                                  return;
                                                }
                                                await printController.getSingleUser(data.createdBy!).then((e){
                                                  openNewTabInvoice(context, printController.invoicePrintModel(data, controller.invoiceTextEditingControllerList[index].text, controller.invoiceDateList[index], printController.singleCustomerModel.value));
                                                });                                          },
                                              icon: printController.isLoading.value ? SizedBox(
                                                  width: 20, height: 20,
                                                  child: CircularProgressIndicator()) : Icon(Icons.print, color: Colors.blueGrey,)
                                          );
                                        }
                                      )
                                    ],
                                  ),
                                ),



                                //
                                // //Action button
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: SizedBox(
                                //       width: 130,
                                //       child: Obx(() {
                                //         return Checkbox(
                                //           value: controller.selectedOrdersItems.contains(data),
                                //           onChanged: (bool? value) {
                                //             if(value == true){
                                //               controller.selectedOrdersItems.add(data!);
                                //             }else{
                                //               controller.selectedOrdersItems.remove(data!);
                                //             }
                                //           },
                                //
                                //         );
                                //       }
                                //       )
                                //   ),
                                // ),
                                //
                                //
                                //
                                //
                                //
                                //
                                //



                              ],
                            ),
                          );
                        },
                      );
                    }
                    ),
                  ) ,
                  onSearch: (){
                  },
                  onChanged: (v){

                  },


                );
              }

              }
            ),
            SizedBox(height: 30,),
            Center(
              child: Obx(() {
                  return InkWell(
                    onTap: ()async{
                      if(printController.isGettingData.value){
                        return null;
                      }
                      await printController.getAllProduct().then((e){
                        openPreparationNewTab(context, printController.preparInvoiceModel(printController.productListModel.value.data!, controller.shortOrderList, authController.myprofiel.value));
                      });
                    },
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: printController.isGettingData.value ? Center(child: CircularProgressIndicator(color: Colors.white,),) : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print, color: Colors.white, size: 20,),
                          SizedBox(width: 10,),
                          Text("Export preparation",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16
                            ),)
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
            SizedBox(height: 30,),



          ],
        )
      ),
    );
  }
}
