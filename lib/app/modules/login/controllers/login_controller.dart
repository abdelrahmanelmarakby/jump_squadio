import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:jump_squadio/app/data/models/user_model.dart';

import '../../../../core/services/shared_pref.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoadingUsers = false;
  Future<bool> Login(String name, String pass) async {
    isLoadingUsers = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (name == "admin" && pass == "admin") {
        SharedPrefService().saveIsFirstTime();
        Get.toNamed(Routes.HOME);
      } else
        Get.snackbar("Login failed", "Incorrect user name or password");
    });

    return isLoadingUsers;
  }

  @override
  void onInit() {}

  @override
  void onClose() {
    super.onClose();
  }
}
