import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tubescozy/modules/signup/signup_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../main.dart';
import '../../utils/constant.dart';
class SignupView extends GetView<SignupController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Akun Cozy',
        style: TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:
          Container(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Image.asset('img/CozyLogo.png'),
                  TextField(
                    controller: controller.emailC,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: controller.passC,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    child: Container(
                      width: 200,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: kActiveShadowColor,
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: ()=> authC.signup(controller.emailC.text, controller.passC.text),
                          child: Center(
                            child: Text("Daftar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya akun ? "),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("Login disini",
                        style: TextStyle(
                          color: Colors.deepOrange
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )


    );
  }
}