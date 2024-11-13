import 'package:flutter/material.dart';

import '../../../utility/app_const.dart';
class TopbarWidgets extends StatelessWidget {
  const TopbarWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  Text("Hi, ('Super Admin')", style: TextStyle(color: AppColors.textLightColor, fontSize: 16, fontWeight: FontWeight.w400),),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: 200,
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: AppColors.textLightColor, fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          filled: true,
                          fillColor: AppColors.lightGrey,
                          prefixIcon: Icon(Icons.search, color: AppColors.textLightColor,),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
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
