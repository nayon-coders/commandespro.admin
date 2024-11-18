
import 'package:commandespro_admin/comman/app_input.dart';
import 'package:commandespro_admin/comman/dropdown2.dart';
import 'package:commandespro_admin/features/customers_screen/controller/user.controller.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/app_table/app.table.dart';
import '../../../comman/app_table/table.header.dart';
import '../../../data/global/global_variable.dart';
import '../../ajouter_cmd/widget/input_filed.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {

  final AppUserController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllUser("1");
    });
  }

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      body:Container(
        padding: const EdgeInsets.all(20),
        margin:const EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: AppTable(
          title: "User List",
          headersChildren:const [
            TableHeader(name: "ID", width: 50),
            TableHeader(name: "Name Sign", width: 150),
            TableHeader(name: "Kind", width: 150),
            TableHeader(name: "Phone", width: 150),
            TableHeader(name: "E-mail	", width: 200),
            TableHeader(name: "Postal Code	", width: 100),
            TableHeader(name: "Status", width: 120),
            TableHeader(name: "Action", width: 140),
          ],
          row:Obx(() {
            if(controller.allUserList.value.isEmpty){
              if(controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator(),);
              }else {
                return const Center(child: Text("No Data Found"),);
              }
            }else{
              return ListView.builder(
                  physics:const  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:controller.allUserList.length,
                  itemBuilder: (context,index){
                    var data = controller.allUserList![index];
                    return  Container(
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
                          TableHeader(name:"${data.id}", width: 50),

                          //First Name
                          Container(
                            width: 150,
                              padding: EdgeInsets.all(6),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: InputFiled(
                                  hint: "Name",
                                  controller: controller.nameControllerList.value[index],
                              )
                          ),
                          Container(
                              width: 150,
                              height: 40,
                              child: DropDown2(
                                hint: "${data.accountType}",
                                items: GlobalVariable.accountType,
                                onChange: (v){
                                  controller.selectedAccountType.value[index] = v!;
                                },
                              )
                          ),
                          //Email
                      Container(
                        width: 150,
                          padding: EdgeInsets.all(6),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: InputFiled(
                              hint: "Phone",
                              controller: controller.accountPhoneControllerList.value[index],
                          )
                      ),
                          //Role
                          Container(
                            width: 200,
                              padding: EdgeInsets.all(6),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: InputFiled(
                                  hint: "Email",
                                  controller: controller.emailControllerList.value[index],
                              )
                          ),

                          Container(
                            width: 100,
                              padding: EdgeInsets.all(6),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: InputFiled(
                                  hint: "Post Code",
                                  controller: controller.postCodeControllerList.value[index],
                              )
                          ),


                          //Status
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              color:Colors.green.shade200,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child:  DropDown2(
                              hint: "${data.status}",
                              items: GlobalVariable.accountStatus,
                              onChange: (v){
                                controller.updateUserStatus(data.id.toString(), v!.toString(), index);
                                controller.selectedAccountStatus.value[index] = v!;
                              },
                            ),
                          ),

                          //Action button
                          SizedBox(
                            width: 140,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx((){
                                        return IconButton(
                                            onPressed: (){
                                              controller.isUpdating.value ? null :  controller.updateUser(data.id.toString(), index);
                                            },
                                            icon:controller.isUpdating.value ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator()) : Icon(Icons.save,color: Colors.green,)
                                        );
                                      }
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          Get.defaultDialog(
                                            title: "Are you sure?",
                                            content:const  Text("Do you want to delete User?"),
                                            onConfirm: (){
                                              controller.deleteUser(data.id.toString());
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.delete,color: Colors.red,))

                                  ],
                                ),
                              ),
                            ),
                          ),










                        ],
                      ),
                    );
                  });
            }

          }
          ),

          onSearch: (){

          },
          onChanged: (v){
            controller.searchCustomerByName(v!);
          },

        ),

      ),
    );
  }
}
