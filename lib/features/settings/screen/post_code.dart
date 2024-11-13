import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/products/controller/postcode.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_input.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';

class PostCode extends StatefulWidget {
   PostCode({super.key});

  @override
  State<PostCode> createState() => _PostCodeState();
}

class _PostCodeState extends State<PostCode> {
  final _posterCode = TextEditingController();

  final PostCodeController controller = Get.find<PostCodeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllPostCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body:Container(
          padding:const EdgeInsets.only(left: 100, right: 100, top: 40, bottom: 50),
          width:Get.width ,
          child: Column(
            children: [
              Container(
                width: Get.width*0.50,
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
                   const Center(child: Text("Postal Code Management",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: AppColors.primaryColor),)),
                    const SizedBox(height: 20,),

                    //Enter Postal Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width:MediaQuery.sizeOf(context).width*0.38,
                            child: AppInput(hint: " Add a postal code", controller: controller.postCode.value, text: "Postal Code*")),
                        const SizedBox(width: 10,),
                        Obx(() {
                            return AppButton(
                              isLoading: controller.isDataAdding.value,
                              onClick:(){
                                controller.addPostCode();
                              },
                              text: "Add",
                              width: 100,
                              height: 50,
                            );

                          }
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // DataTable(
                    //   border: TableBorder.all(color: Colors.grey),
                    //   columnSpacing: 200,
                    //   headingRowColor:const WidgetStatePropertyAll(AppColors.primaryColor),
                    //   dividerThickness: 1,
                    //
                    //     columns: const [
                    //       DataColumn(label:Text( "Postal Code")),
                    //       DataColumn(label:Text( "Move")),
                    //       DataColumn(label:Text( "Action")),
                    //     ],
                    //     rows:  [
                    //       DataRow(cells: [
                    //        DataCell(Text("123324")),
                    //        DataCell(Text("123324")),
                    //        DataCell(Icon(Icons.delete,color: Colors.red,)),
                    //       ])
                    //     ],
                    // ),



                    //Postal List Table
                    Container(
                      width: Get.width*0.48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [

                          //Postal Code Table Header
                          Container(
                            height: 45,
                            color: AppColors.primaryColor,
                            child:const Padding(
                              padding:  EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                      child: Text("Postal Code",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),)),

                                  SizedBox(
                                    width: 100,
                                      child: Text("Action",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),)),
                                ],

                              ),
                            ),
                          ),

                          //Postal Code Table List

                          Obx(() {
                            if(controller.isDataGetting.value){
                              return const Center(child: CircularProgressIndicator());
                            }else{
                              if(controller.postCodeModel.value.data!.isEmpty){
                                return const Center(child: Text("No data found"));
                              }else{
                                return ListView.builder(
                                    physics:const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.postCodeModel.value.data!.length,
                                    itemBuilder: (context,index){
                                      var data = controller.postCodeModel.value.data![index];
                                      return Container(
                                        height: 50,
                                        padding:const EdgeInsets.only(left: 10,right: 10),
                                        decoration:const BoxDecoration(
                                            border: Border.symmetric(horizontal: BorderSide(color: Colors.grey))
                                        ),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            //Postal Code
                                            SizedBox(
                                              width: 200,
                                              child: Text("${data.code}",style: pTextStyle(),
                                              ),
                                            ),

                                            //Move

                                            //Action
                                            SizedBox(
                                                width: 100,
                                                child: Obx(() {
                                                  if(controller.isDataDeleting.value){
                                                    return Center(child: CircularProgressIndicator());
                                                  }else{
                                                    return IconButton(onPressed: (){
                                                      controller.deletePost(data.id);

                                                    }, icon:const Icon(Icons.delete,color: Colors.red,));
                                                  }
                                                  }
                                                )),
                                          ],
                                        ),
                                      );
                                    });
                              }
                            }

                            }
                          )

                        ],
                      ),
                    )


                  ],
                ),
              ),
            ],
          ),

    ));
  }
}
