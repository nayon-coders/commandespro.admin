import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/admin_profile_model.dart';
class GlobalVariable {
  static final GlobalVariable _singleton = GlobalVariable._internal();

  factory GlobalVariable() {
    return _singleton;
  }

  GlobalVariable._internal();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  // Add your global variable here
  static final Rx<AdminProfileModel> adminProfile= AdminProfileModel().obs;

}