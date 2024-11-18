import 'package:commandespro_admin/data/model/all_order_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

class InvoiceController extends GetxController {

  RxList<String> paymentStatusList = <String>["Paid", "Unpaid"].obs;
  RxString selectedPaymentStatus = ''.obs;
  RxString selectedCustomerName = ''.obs;
  RxList<OrderItem> shortOrderList = <OrderItem>[].obs;
  RxList<OrderItem> selectedOrdersItems = <OrderItem>[].obs;
  RxBool isAllSelectedOrder = false.obs;

  RxString statDate = ''.obs;
  RxString endDate = ''.obs;
  var filteringStartDate = DateTime.now().obs;
  var filteringEndDate = DateTime.now().obs;

   RxString get invoiceDate => DateFormat("MM/dd/yyyy").format(DateTime.now()).obs;
   RxString? get invoiceTotalOrderAmount => shortOrderList.map((e) => e.total)!.reduce((a, b) => a! + b! )!.toStringAsFixed(2).obs;
   RxString? get totalTaxAmount => shortOrderList.map((e) => e.taxAmount)!.reduce((a, b) => a! + b! )!.toStringAsFixed(2).obs;
   String get invoiceTotalOrderAmountWithTax => (double.parse("${invoiceTotalOrderAmount}") + double.parse("${totalTaxAmount}")).toStringAsFixed(2);



  //short order data with start date, end date and payment status and also customer name
  shortOrderData(AllOrderModel allOrderModel) {
    shortOrderList.clear();
    {
      allOrderModel.data!.forEach((element) {

        print("start date: ${filteringStartDate.value}");
        print("end date: ${filteringEndDate.value}");
        print("selected customer name: ${selectedCustomerName.value}");
        print("selected payment status: ${selectedPaymentStatus.value}");
        print("element company: ${element.company}");
        print("element payment status: ${element.orderStatus}");
        print("element created at: ${element.createdAt}");
        //short with start date to end date, payment status and customer name
        //short with start date to end date
        if (element.createdAt!.isAfter(filteringStartDate.value) &&
            element.createdAt!.isBefore(filteringEndDate.value) ||
            element.company == selectedCustomerName.value) {
          shortOrderList.add(element);
        }
      });
      return shortOrderList;
    }
  }
}