import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jump_squadio/app/modules/home/views/home_view.dart';
import 'package:jump_squadio/app/routes/app_pages.dart';
import 'package:jump_squadio/core/services/shared_pref.dart';
import 'package:jump_squadio/core/values/localization/local_keys.dart';
import 'package:scratcher/scratcher.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            controller.Login(controller.name.text, controller.pass.text);
          },
          child: const Icon(Icons.login),
        ),
        body: GetBuilder<LoginController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 5,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocalKeys.kName.tr,
                      ),
                    ),
                    TextFormField(
                      controller: controller.name,
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                      ),
                    ),
                    TextFormField(
                      controller: controller.pass,
                      obscureText: true,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                TextButton(
                    onPressed: () async {
                      bool isLogged = await controller.Login(
                          controller.name.text, controller.pass.text);
                      print(isLogged);
                      if (!isLogged) {}
                    },
                    child: Text(LocalKeys.kLogin.tr)),
                const Spacer(
                  flex: 5,
                )
              ],
            ),
          );
        })); //)
  }
}
