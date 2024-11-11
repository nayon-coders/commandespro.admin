import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/images/logo.png", width: 200, height: 100,),
          Text("© 2022 CommandesPro. All rights reserved.", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
        ],
      ),

    );
  }
}
