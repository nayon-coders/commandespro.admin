import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/controller/date_picker.dart';
import 'package:commandespro_admin/features/customers_screen/controller/user.controller.dart';
import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:commandespro_admin/features/order/controller/order_ontroller.dart';
import 'package:commandespro_admin/utility/app_const.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/dropdown2.dart';
import '../../../data/model/single_customer_model.dart';
import '../../../data/model/user.list.model.dart';
import '../controller/controller.dart';
class FilterOptionsView extends StatefulWidget {
  const FilterOptionsView({super.key});

  @override
  State<FilterOptionsView> createState() => _FilterOptionsViewState();
}

class _FilterOptionsViewState extends State<FilterOptionsView> {
  final InvoiceController controller = Get.find();
  final DatePickerController datePickerController = Get.put(DatePickerController());
  final AppUserController customerController = Get.find();
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      customerController.getAllUser("1");
      orderController.getAllOrder();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Start date",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Obx(() {
              return InkWell(
                onTap: () async{
                  await datePickerController.pickDate(context);
                  controller.statDate.value = datePickerController.formattedDate.value;
                  controller.filteringStartDate.value = datePickerController.selectedDate.value;
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: controller.statDate.value.isEmpty ? Text("Select Date",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.w400
                      ),) : Text(controller.statDate.value,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              );
            }
            ),
          ],
        ),
        SizedBox(width: 30,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("End date",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Obx(() {
              return InkWell(
                onTap: () async{
                  await datePickerController.pickDate(context);
                  controller.endDate.value = datePickerController.formattedDate.value;
                  controller.filteringEndDate.value = datePickerController.selectedDate.value;
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: controller.endDate.value.isEmpty ? Text("Select Date",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.w400
                      ),) : Text(controller.endDate.value,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              );
            }
            ),
          ],
        ),
        SizedBox(width: 30,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            //show all customer in a dropdown list
            Obx(() {
              if(customerController.isLoading.value){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                return Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<UserList>(
                      isExpanded: true,
                      hint: Text(
                        'Select Customer',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: customerController.activeUserList.value.map((item) {
                        return DropdownMenuItem<UserList>(
                          value: item,
                          child: Text(
                            item.company ?? '', // Add null safety check here
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      value: customerController.selectedUser.value, // Ensure a valid value is selected
                      onChanged: (value) {
                        if (value != null) {
                          print("Selected User: ${value.name}");
                          customerController.selectedUser.value = value;
                          controller.selectedCustomerName.value = value.company!;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 1, color: Colors.grey.shade300),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 50,
                      ),
                    ),
                  ),
                );
              }

            }
            ),
          ],
        ),
        SizedBox(width: 30,),

        Column(
          children: [
            SizedBox(height: 30,),
            AppButton(
              onClick: (){
                //generate invoice
                var data = controller.shortOrderData(orderController.allOrderModel.value);
                print("Data: $data");
              },
              text: "Generate Invoice",
            ),
          ],
        )

      ],
    );
  }
}
