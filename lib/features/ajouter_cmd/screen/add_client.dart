import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/ajouter_cmd/widget/selected_button.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_input.dart';
import '../../../comman/dropdown2.dart';
import '../../../controller/product_json.dart';
import '../../../utility/app_const.dart';
import '../../../utility/text_style.dart';

class AddClient extends StatefulWidget {
   AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _email = TextEditingController();

  final _companyName = TextEditingController();

  final _taught = TextEditingController();

  final _siretNumber = TextEditingController();

  final _billingAddress  = TextEditingController();

  final _city = TextEditingController();

  final _postal = TextEditingController();

  final _billingContactName = TextEditingController();

  final _billingContactEmail = TextEditingController();

  final _mobile = TextEditingController();

  final _dateTime = TextEditingController();

  final _paymentMethod = TextEditingController();

  final _status = TextEditingController();

  String? selectPayment;

  String? selectStatus;
  bool isRestaurantSelected = false;
  bool isRevendeurSelected = false;
  bool isGrossisteSelected = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body:Container(
          width: Get.width,
          padding:const EdgeInsets.only(left: 100, right: 100, top: 40, bottom: 50),
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
                    const Text("Ajouter un Client",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: AppColors.primaryColor),),
                    const SizedBox(height: 15,),
                    Text("Choisir le profil du client *",style: boldTextStyle(),),
                    const SizedBox(height: 20,),
                    Row(
                      children: [

                        SelectedButton(onClick: (){ setState(() {
                          isRestaurantSelected = true;
                          isRevendeurSelected = false;
                          isGrossisteSelected = false;
                        });
                          },
                            name: "Restaurant",
                          bgColors: isRestaurantSelected?AppColors.primaryColor:Colors.white,
                          textColor:isRestaurantSelected?Colors.white:AppColors.primaryColor ,
                        ),
                        const SizedBox(width: 10,),
                        SelectedButton(onClick: (){ setState(() {
                          isRestaurantSelected = false;
                          isRevendeurSelected = true;
                          isGrossisteSelected = false;
                        });
                        },
                          name: "Revendeur",
                          bgColors: isRevendeurSelected?AppColors.primaryColor:Colors.white,
                          textColor:isRevendeurSelected?Colors.white:AppColors.primaryColor ,
                        ),

                        const SizedBox(width: 10,),
                        SelectedButton(onClick: (){ setState(() {
                          isRestaurantSelected = false;
                          isRevendeurSelected = false;
                          isGrossisteSelected = true;
                        });
                        },
                          name: "Grossiste",
                          bgColors: isGrossisteSelected?AppColors.primaryColor:Colors.white,
                          textColor:isGrossisteSelected?Colors.white:AppColors.primaryColor ,
                        ),


                      ],
                    ),
                    const SizedBox(height: 30,),

                    AppInput(hint: "Indiquez I email du client", controller: _email, text: "Email"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Nom de la societe tel que sur le KBIS ", controller: _companyName, text: "Nom de la Societe*"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Nom commercial de la societe", controller: _taught, text: "Enseigne*"),
                    const SizedBox(height:15,),

                    AppInput(hint: "N SIRET tel que sur le KBIS", controller: _siretNumber, text: "Numéro de Siret *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Adresse", controller: _billingAddress, text: "Adresse de Facturation *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "ville", controller: _city, text: "Ville*"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Code postal", controller: _postal, text: "Code postal *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Nom et Prenom", controller:_billingContactName, text: "Nom du Contact Facturation *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Email de contact", controller: _billingContactEmail, text: "Email du Contact Facturation *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Numero de mobile ou ligne directe", controller: _mobile, text: "Mobile / Ligne directe *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "mm/dd/yy", controller: _dateTime, text: "Date de Création du Compte",suffixIcon:const Icon(Icons.date_range),),
                    const SizedBox(height:20,),

                    AppInput(hint: "Prelevement SEPA", controller: _paymentMethod, text: "Méthode de Paiement"),
                    const SizedBox(height:20,),

                    AppInput(hint: "En Attente", controller: _status, text: "Statut"),
                    const SizedBox(height:20,),

                    const Text("Méthode de Paiement",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    const SizedBox(height: 10,),
                    DropDown2(
                        items: ProductJson.payment,
                        value: selectPayment,
                        hint: "Prelevement SEPA",
                        onChange: (v){
                          setState(() {
                            selectPayment = v;
                          });
                        }
                    ),

                    const SizedBox(height:20,),

                    const Text("Statut",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    const SizedBox(height: 10,),
                    DropDown2(
                        items: ProductJson.status,
                        value: selectStatus,
                        hint: "En Attente",
                        onChange: (v){
                          setState(() {
                            selectStatus = v;
                          });
                        }
                    ),

                    const SizedBox(height: 30,),

                    const Text("Adresses de Livraison",style:TextStyle(color: AppColors.primaryColor,fontSize: 24,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 25,),

                    AppButton(onClick: (){}, text: "Ajouter une adresse de livraison",width: double.infinity,bgColor: Colors.green,),
                    const SizedBox(height: 15,),
                    AppButton(onClick: (){}, text: "Ajouter le Client",width: double.infinity,),
                  ],
                ),
              ),



            ],
          ),
        ),
    );
  }
}
