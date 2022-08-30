import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/values/assets.dart';
import '../../core/values/localization/local_keys.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.kConnectionError,
            width: Get.width,
            height: 329,
          ),
          Text(
            LocalKeys.kNoInternetConnection.tr,
            style: Get.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
