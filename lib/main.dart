import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jump_squadio/core/services/localization_service.dart';
import 'package:jump_squadio/core/services/shared_pref.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  Get.put(LocalizationService());
  Get.put(SharedPrefService());

  //Get.find<LocalizationServices>
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
