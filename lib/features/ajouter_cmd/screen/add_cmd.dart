import 'package:commandespro_admin/features/ajouter_cmd/widget/input_filed.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/AppButton.dart';
import '../../../comman/app_input.dart';
import '../../../comman/dropdown2.dart';
import '../../../controller/product_json.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';
import '../widget/vta_list_tile.dart';

class AddCmd extends StatefulWidget {
  const AddCmd({super.key});

  @override
  State<AddCmd> createState() => _AddCmdState();
}

class _AddCmdState extends State<AddCmd> {
  final _orderNumber = TextEditingController();
  final _client  = TextEditingController();
  final _email  = TextEditingController();
  final _phone  = TextEditingController();
  final _address  = TextEditingController();
  final _datetime = TextEditingController();
  final _productNumber = TextEditingController();
  final _vat = TextEditingController();
  final _quantity= TextEditingController();
  final _priceVat = TextEditingController();
  final _totalVat = TextEditingController();
  final _description = TextEditingController();

  String? selectedValue;
  String? selectStatus;

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
                    const Center(child: Text("Ajouter une Commande",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 40,color: AppColors.primaryColor))),
                    const SizedBox(height: 10,),
                   const Text("Détails de la commande",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.textDarkColor)),

                    AppInput(hint: "Enter order number ", controller: _orderNumber, text: "Numéro de commande :"),
                    const SizedBox(height:20,),

                    AppInput(hint: "select date",suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.date_range)), controller: _datetime, text: "Date et heure de livraison :"),
                    const SizedBox(height:20,),

                    const Text("Statut de la commande :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    const SizedBox(height: 10,),
                    DropDown2(
                        items: ProductJson.orderStatus,
                        value: selectStatus,
                        hint: "En preparation",
                        onChange: (v){
                          setState(() {
                            selectStatus = v;
                          });
                        }
                    ),

                    const SizedBox(height: 30,),
                    const Text("Informations du client",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    const SizedBox(height: 10,),
                    AppInput(hint: "Nom du client", controller: _client, text: "Client (Société) :"),

                    const SizedBox(height: 20,),
                    AppInput(hint: "Email du client", controller: _email, text: "Email :"),

                    const SizedBox(height: 20,),
                    AppInput(hint: "Telephone du client", controller: _phone, text: "Telephone :"),

                    const SizedBox(height: 20,),
                    const Text("Adresse de Livraison",style:TextStyle(color: AppColors.textDarkColor,fontSize: 16,fontWeight: FontWeight.bold)),

                    const SizedBox(height: 15,),
                    AppInput(hint: "Adresse de Livraison", controller: _address, text: "Adresse :"),

                    const SizedBox(height:20,),

                    const Text("Livreur :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    const SizedBox(height: 10,),
                    DropDown2(
                        items: ProductJson.deliveryBoy,
                        value: selectedValue,
                        hint: "Jean Dupont",
                        onChange: (v){
                          setState(() {
                            selectedValue = v;
                          });
                        }
                    ),

                    const SizedBox(height: 20,),

                    //data table product name,quantity,vat
                    DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      //columnSpacing: 100,
                      dataRowMaxHeight: 110,
                      dataRowMinHeight: 110,
                      headingRowColor:const WidgetStatePropertyAll(AppColors.primaryColor),
                      dividerThickness: 1,

                        columns: const [
                          DataColumn(label:Text( "Product",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,),)),
                          DataColumn(label:Text( "Quantité",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,),)),
                          DataColumn(label:Text( "Commentaire",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,),)),
                          DataColumn(label:Text( "Prix Unitaire HT",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,),)),
                          DataColumn(label:Text( "TVA (%)",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,),)),
                          DataColumn(label:Text( "Total HT",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,),)),
                        ],
                        rows:  [
                          DataRow(cells: [
                           DataCell(
                               SizedBox(
                                 height: 35,
                                 width: 150,
                                 child: InputFiled(
                                     hint: "Nom du product", controller: _productNumber),
                               )
                           ),


                           DataCell(SizedBox(
                             height: 35,
                             width: 50,
                             child: InputFiled(
                               textType: TextInputType.number,
                                 hint: "Qu", controller: _quantity),
                           )),



                           DataCell(SizedBox(
                             width: 100,
                             child: InputFiled(
                               maxLine: 4,
                                 hint: "Commentaire", controller: _description),
                           )),


                           DataCell(SizedBox(
                             height: 35,
                             width: 150,
                             child: InputFiled(
                                 hint: "Prix Unitaire HT", controller: _priceVat),
                           )),


                           DataCell(SizedBox(
                             height: 35,
                             width: 50,
                             child: InputFiled(
                                 textType: TextInputType.number,
                                 hint: "TV", controller: _vat),
                           )),


                           DataCell(SizedBox(
                             height: 35,
                             width: 80,
                             child: InputFiled(
                                 hint: "Total HT", controller: _totalVat),
                           )),
                          ])
                        ],
                    ),
                    const SizedBox(height: 20,),
                    AppButton(onClick: (){}, text: "Ajouter un product"),
                    SizedBox(height: 30,),

                    //Postal List Table
                    VtaListTile(title: "Sous-total HT :",),
                    SizedBox(height: 20,),
                    VtaListTile(title: "TVA (20%) :",),
                    SizedBox(height: 20,),
                    VtaListTile(title: "TVA (5,5%) :",),
                    SizedBox(height: 20,),
                    VtaListTile(title: "Total TTC :",),
                    SizedBox(height: 20,),
                    AppButton(onClick: (){}, text: "Enregisrer la Commande")




                  ],
                ),
              ),



            ],
          ),
        ),
    );
  }
}
