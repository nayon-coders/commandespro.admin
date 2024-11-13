import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_input.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';

class PostCode extends StatelessWidget {
   PostCode({super.key});
  final _posterCode = TextEditingController();

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
                   const Center(child: Text("Postal Code Management",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: AppColors.primaryColor),)),
                    const SizedBox(height: 20,),

                    //Enter Postal Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width:MediaQuery.sizeOf(context).width*0.38,
                            child: AppInput(hint: " Add a postal code", controller: _posterCode, text: "Postal Code*")),
                        const SizedBox(width: 10,),
                        AppButton(onClick:(){}, text: "Add",width: 100,height: 50,),
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
                                    width: 200,
                                      child: Text("Move",style:TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),)),
                                  SizedBox(
                                    width: 100,
                                      child: Text("Action",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),)),
                                ],

                              ),
                            ),
                          ),

                          //Postal Code Table List

                          ListView.builder(
                            physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                              itemBuilder: (context,index){
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
                                    child: Text("${index+1}",style: pTextStyle(),
                                    ),
                                  ),

                                  //Move
                                  SizedBox(
                                    width: 200,
                                    child:  Row(
                                      children: [
                                        IconButton(onPressed: (){}, icon:const Icon(Icons.archive,color: Colors.blue,)),
                                        IconButton(onPressed: (){}, icon:const Icon(Icons.unarchive,color: Colors.blue,)),


                                      ],
                                    ),
                                  ),

                                  //Action
                                  SizedBox(
                                      width: 100,
                                      child: IconButton(onPressed: (){}, icon:const Icon(Icons.delete,color: Colors.red,))),
                                ],
                              ),
                            );
                          })

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
