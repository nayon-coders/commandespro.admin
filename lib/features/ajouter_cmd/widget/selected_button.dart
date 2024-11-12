import 'package:flutter/material.dart';

import '../../../utility/app_const.dart';

class SelectedButton extends StatelessWidget {
  const SelectedButton({super.key, required this.onClick, required this.name, this.bgColors=Colors.white, this.textColor=AppColors.primaryColor});
  final VoidCallback onClick;
  final String name;
  final Color? bgColors;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 40,
        padding:const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.primaryColor),
          color:bgColors,
        ),
        child:  Text("Restaurant",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: textColor),),
      ),
    );
  }
}
