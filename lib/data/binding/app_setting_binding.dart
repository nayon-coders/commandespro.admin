import 'package:commandespro_admin/features/app_screen/controller/privacy_policy_controller.dart';
import 'package:commandespro_admin/features/app_screen/controller/update_password_controller.dart';
import 'package:get/get.dart';

class AppSettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(()=>UpdatePasswordController());
    Get.lazyPut<PrivacyPolicyController>(()=>PrivacyPolicyController());
  }

}