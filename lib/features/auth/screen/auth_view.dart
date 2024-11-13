import 'package:commandespro_admin/comman/AppButton.dart';
import 'package:commandespro_admin/features/auth/controller/auth_controller.dart';
import 'package:commandespro_admin/utility/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
         padding: EdgeInsets.all(30),
          width: 500,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png",width: 200,),
              const SizedBox(height: 20,),
               Text("Login",style: h1TextStyle(),),
              const SizedBox(height: 20,),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Obx(() {
                  return AppButton(
                      isLoading: controller.isLoading.value,

                      onClick: (){
                        controller.adminLogin(controller.nameController.text, controller.passwordController.text);
                      }, text: "Login");
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}
