import 'package:commandespro_admin/controller/editable_controller.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/settings/controller/admin.role.controller.dart';
import 'package:commandespro_admin/features/customers_screen/controller/user.controller.dart';
import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../comman/app_table/app.table.dart';
import '../../../comman/app_table/table.header.dart';

class AdminList extends StatefulWidget {
   AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  final _searchController = TextEditingController();

  final AdminRoleController controller = Get.find<AdminRoleController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getAllAdmin();
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
              TableHeader(name: "First Name", width: 100),
              TableHeader(name: "Last Name", width: 100),
              TableHeader(name: "Email", width: 200),
              TableHeader(name: "Role", width: 100),
              TableHeader(name: "Status", width: 80),
              TableHeader(name: "Action", width: 140),
            ],
            row:Obx(() {
              if(controller.allAdminListModel.value.data == null){
                return const Center(child: CircularProgressIndicator(),);
              }else{
                return ListView.builder(
                    physics:const  NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:controller.allAdminList.length,
                    itemBuilder: (context,index){
                      var data = controller.allAdminList![index];
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
                            TableHeader(name:"${index+1}", width: 50),

                            //First Name
                            TableHeader(name: "${data.firstName}", width: 100),
                            TableHeader(name: "${data.lastName}", width: 100),
                            //Email
                            TableHeader(name: "${data.email}", width: 200),
                            //Role
                            TableHeader(name: "${data.roleName}", width: 100),


                            //Status
                            Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                color:Colors.green.shade200,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text("Active",style: TextStyle(color: Colors.green),),
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
                                      IconButton(
                                          onPressed: (){
                                            Get.defaultDialog(
                                              title: "Are you sure?",
                                              content:const  Text("Do you want to edit User?"),
                                              onConfirm: (){
                                                // Get.toNamed(Routes.EDIT_USER,arguments: data);
                                                controller.setValueToEdit(data);
                                                Get.toNamed(AppRoute.edit_new_user,arguments: data);

                                              },
                                            );
                                          },
                                          icon:const Icon(Icons.edit,color: Colors.amber,)
                                      ),
                                      IconButton(
                                          onPressed: (){
                                            Get.defaultDialog(
                                              title: "Are you sure?",
                                              content:const  Text("Do you want to delete User?"),
                                              onConfirm: (){
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
              controller.searchAdmin(_searchController.text);
            },
            onChanged: (v){
              controller.searchAdmin(v);
            },
            searchController: _searchController,

          ),

        ),
    );
  }
}
