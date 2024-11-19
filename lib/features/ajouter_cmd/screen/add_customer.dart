import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/data/global/global_variable.dart';
import 'package:commandespro_admin/features/ajouter_cmd/controller/customer_controller.dart';
import 'package:commandespro_admin/features/ajouter_cmd/widget/selected_button.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../comman/app_input.dart';
import '../../../../../../../comman/dropdown2.dart';
import '../../../../../../../controller/product_json.dart';
import '../../../../../../../utility/app_const.dart';
import '../../../../../../../utility/text_style.dart';
import '../widget/ShippingAddressView.dart';

class AddCustomer extends StatefulWidget {
   AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {


  final CustomerController controller = Get.find<CustomerController>();


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
                    Obx((){
                        return SizedBox(
                          width: Get.width,
                          height: 45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: GlobalVariable.accountType.length,
                            itemBuilder: (_, index){
                              return Obx(() {
                                  return InkWell(
                                    onTap: (){

                                      if(controller.selectedRole.contains(GlobalVariable.accountType[index])){
                                        controller.selectedRole.clear();
                                      }else{
                                        controller.selectedRole.add(GlobalVariable.accountType[index]);
                                      }
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 45,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: controller.selectedRole.contains(GlobalVariable.accountType[index]) ? AppColors.primaryColor :Colors.white,
                                        border: Border.all(width: 1, color: AppColors.primaryColor),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text(GlobalVariable.accountType[index],style: TextStyle(color: controller.selectedRole.contains(GlobalVariable.accountType[index]) ? Colors.white : AppColors.primaryColor,fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                        );
                      }
                    ),

                    const SizedBox(height: 30,),


                    AppInput(
                        hint: "Indiquez I email du client",
                        controller: controller.emailController.value, text: "Email"
                    ),
                    const SizedBox(height:20,),

                    AppInput(hint: "Nom de la societe tel que sur le KBIS ", controller: controller.companyController.value, text: "Nom de la Societe*"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Nom commercial de la societe", controller: controller.brandController.value, text: "Enseigne*"),
                    const SizedBox(height:15,),

                    AppInput(hint: "N SIRET tel que sur le KBIS", controller: controller.stratController.value, text: "Numéro de Siret *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Adresse", maxLine: 2, controller: controller.addressController.value, text: "Adresse de Facturation *",
                      onChanged: (v){
                        controller.shippingAddress.value.text = v!;
                      },
                    ),
                    const SizedBox(height:20,),

                    AppInput(hint: "ville", controller: controller.cityController.value, text: "Ville*",
                      onChanged: (v){
                        controller.shippingCity.value.text = v!;
                      },
                    ),
                    const SizedBox(height:20,),

                    AppInput(hint: "Code postal", controller: controller.postCodeController.value, text: "Code postal *",
                      onChanged: (v){
                        controller.shippingPostCode.value.text = v!;
                      },
                    ),
                    const SizedBox(height:20,),

                    AppInput(hint: "Nom et Prenom", controller:controller.contactFacturation.value, text: "Nom du Contact Facturation *"),
                    const SizedBox(height:20,),

                    AppInput(hint: "Email de contact", controller: controller.contactEmail.value, text: "Email du Contact Facturation *",
                      onChanged: (v){
                        controller.shippingEmail.value.text = v!;
                      },
                    ),
                    const SizedBox(height:20,),

                    AppInput(hint: "Numero de mobile ou ligne directe", controller: controller.contactPhone.value, text: "Mobile / Ligne directe *"),
                   // const SizedBox(height:20,),



                    // const Text("Méthode de Paiement",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    // const SizedBox(height: 10,),
                    // DropDown2(
                    //     items: ProductJson.payment,
                    //     value: selectPayment,
                    //     hint: "Prelevement SEPA",
                    //     onChange: (v){
                    //       setState(() {
                    //         selectPayment = v;
                    //       });
                    //     }
                    // ),
                    //
                    // const SizedBox(height:20,),
                    //
                    // const Text("Statut",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    // const SizedBox(height: 10,),
                    // DropDown2(
                    //     items: ProductJson.status,
                    //     value: selectStatus,
                    //     hint: "En Attente",
                    //     onChange: (v){
                    //       setState(() {
                    //         selectStatus = v;
                    //       });
                    //     }
                    // ),

                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Adresses de Livraison",style:TextStyle(color: AppColors.primaryColor,fontSize: 35,fontWeight: FontWeight.bold)),
                        Obx(() {
                           if(controller.isShippingAddress.value){
                             return  Container(
                               color: AppColors.primaryColor,
                               child: TextButton(
                                 onPressed: (){
                                    controller.isShippingAddress.value = false;
                                 },
                                 child: Text("Close it",
                                   style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),

                                 ),
                               ),
                             );
                           }else{
                             return Container(
                               color: AppColors.primaryColor,
                               child: TextButton(
                                 onPressed: (){
                                   controller.isShippingAddress.value = true;
                                 },
                                 child: Text("Add Shipping Address",
                                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                                 ),
                               ),
                             );
                           }
                          }
                        )
                      ],
                    ),
                    const SizedBox(height: 25,),
                    //shipping address
                    Obx(() {
                      if(controller.isShippingAddress.value){
                        return ShippingAddressView();
                      }else{
                        return Center();
                      }

                      }
                    ),

                    const SizedBox(height: 15,),
                    Obx(() {
                        return AppButton(
                          onClick: (){
                            controller.isSignUp.value ? null : controller.createAccount();
                          },
                          isLoading: controller.isSignUp.value,
                          text: "Ajouter le Client",
                          width: double.infinity,
                        );
                      }
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
    );
  }
}
