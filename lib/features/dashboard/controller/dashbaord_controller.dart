import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app.config.dart';
import '../../../data/model/all_order_model.dart';
import '../../../data/service/api.service.dart';

class SalesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  RxBool isGettingData = false.obs;
  Rx<AllOrderModel> allOrderModel = AllOrderModel().obs;
  getAllOrder() async {
    isGettingData.value = true;
    var response = await ApiService().getApi(AppConfig.ORDER_GET);
    if (response.statusCode == 200) {
      allOrderModel.value = allOrderModelFromJson(response.body);
    }
    isGettingData.value = false;
  }

  //calulation
  // Today's sales total
  double get todayTotalSales {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return allOrderModel.value.data!
        .where((order) => order.deliveryDate!.startsWith(today))
        .map((order) => order.total)
        .fold(0.0, (sum, total) => sum + total!);
  }

  // This week's sales total
  double get weekTotalSales {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1)); // Start of the week (Monday)
    final weekEnd = weekStart.add(Duration(days: 6)); // End of the week (Sunday)

    return allOrderModel.value.data!
        .where((order) {
      final orderDate = DateTime.parse(order!.deliveryDate!);
      return orderDate.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
          orderDate.isBefore(weekEnd.add(const Duration(seconds: 1)));
    })
        .map((order) => order.total)
        .fold(0.0, (sum, total) => sum + total!);
  }

  // This month's sales total
  double get monthTotalSales {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    return allOrderModel.value.data!
        .where((order) {
      final orderDate = DateTime.parse(order.deliveryDate!);
      return orderDate.isAfter(firstDayOfMonth.subtract(const Duration(seconds: 1))) &&
          orderDate.isBefore(lastDayOfMonth.add(const Duration(seconds: 1)));
    })
        .map((order) => order.total)
        .fold(0.0, (sum, total) => sum + total!);
  }
}