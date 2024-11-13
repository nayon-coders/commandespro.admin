import 'package:flutter/material.dart';

import 'app_const.dart';

TextStyle menusTextStyle ()=> const TextStyle(color: Colors.white, fontSize: AppFontSize.defaultFontSize, fontWeight: FontWeight.w600);
TextStyle selectedMenuTextStyle ()=> const TextStyle(color: Colors.black, fontSize: AppFontSize.defaultFontSize, fontWeight: FontWeight.w600);

TextStyle h2TextStyle() => const TextStyle(color: AppColors.textColor, fontSize: 22, fontWeight: FontWeight.w600);

// h1 style for the app
TextStyle h1TextStyle() => const TextStyle(color: AppColors.textColor, fontSize: 30, fontWeight: FontWeight.w600);

// p style for the app
TextStyle pTextStyle() => const TextStyle(color: AppColors.textColor, fontSize: 16, fontWeight: FontWeight.w400);
TextStyle boldTextStyle() => const TextStyle(color: AppColors.textColor, fontSize: 18, fontWeight: FontWeight.w600);
TextStyle formTitleStyle() => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor
);


//