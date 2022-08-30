import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

import 'shared_pref.dart';

class LocalizationService extends GetxService {
  @override
  void onInit() {
    Get.updateLocale(Locale(SharedPrefService.getLocale() ?? "en"));
    super.onInit();
  }

  setLocale(bool isWithRestart) async {
    Get.updateLocale(Locale(Get.locale?.languageCode == 'ar' ? 'en' : 'ar'));
    await SharedPrefService.saveLocale(
        Get.locale?.languageCode == 'ar' ? 'en' : 'ar');

    if (isWithRestart) {
      await Restart.restartApp();
    }
  }

  bool isAr() {
    return Get.locale?.languageCode == 'ar';
  }
}
