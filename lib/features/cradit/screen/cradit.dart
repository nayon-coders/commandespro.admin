import 'package:commandespro_admin/features/menus/screens/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CraditScreen extends StatefulWidget {
  const CraditScreen({super.key});

  @override
  State<CraditScreen> createState() => _CraditScreenState();
}

class _CraditScreenState extends State<CraditScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Text("Under Constration",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
