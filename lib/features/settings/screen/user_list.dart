import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../comman/app_table/app.table.dart';
import '../../../comman/app_table/table.header.dart';

class UserList extends StatelessWidget {
   UserList({super.key});
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body:Container(
          padding:const EdgeInsets.all(50),
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
            row:ListView.builder(
              physics:const  NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 40,
                itemBuilder: (context,index){
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
                    TableHeader(name: "First Name", width: 100),



                    //last Name
                    TableHeader(name: "Last Name", width: 100),




                    //Email
                    TableHeader(name: "Email", width: 200),



                    //Role
                    TableHeader(name: "Role", width: 100),


                    //Status
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        color:Colors.green.shade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:const Center(
                        child: Text("Active",style: TextStyle(color: Colors.green),),
                      ),
                    ),

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
                                onPressed: (){},
                                icon:const Icon(Icons.edit,color: Colors.amber,)
                            ),
                            IconButton(
                                onPressed: (){
                                  Get.defaultDialog(
                                    title: "Are you sure?",
                                    content:const  Text("Do you want to delete product?"),
                                    onConfirm: (){
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete,color: Colors.red,))

                          ],
                        ),
                      ),
                    ),










                  ],
                ),
              );
            }),

            onSearch: (){ },
            onChanged: (v){},
            searchController: _searchController,

          ),

        ),
    );
  }
}
