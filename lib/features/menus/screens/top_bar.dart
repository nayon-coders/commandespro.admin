import 'package:commandespro_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import '../../../routes/app_pages.dart';
import '../../../utility/app_const.dart';
class TopbarWidgets extends StatelessWidget {
  const TopbarWidgets({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    var role = sharedPreferences!.getString("role");
    return LayoutBuilder(
      builder: (context, constraints){
      if (constraints.maxWidth > 600) {
       return Container(
          padding: const EdgeInsets.all(AppPadding.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/logo.png", width: 200, height: 100,),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person,
                      color: AppColors.textLightColor,
                    ),
                  ),
                  Text("Hi, (${role})", style: TextStyle(color: AppColors.textLightColor, fontSize: 16, fontWeight: FontWeight.w400),),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: (){
                      sharedPreferences!.clear();
                      //clear html token
                      html.window.localStorage.remove("token");

                      Get.offAllNamed(AppRoute.login);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }else{
        return Center();
      }

      },
    );
  }
}
