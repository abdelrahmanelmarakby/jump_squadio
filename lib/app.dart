import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jump_squadio/core/services/dynamic_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/views/network_error.dart';
import 'core/values/localization/messages.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _backViewOn = true;
  final botToastBuilder = BotToastInit();

  @override
  void initState() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (!await InternetConnectionChecker().hasConnection) {
        if (!_backViewOn) {
          setState(() {
            _backViewOn = true;
          });
          Get.to(
            () => const NetworkError(),
          );
        }
      } else {
        if (_backViewOn) {
          setState(() {
            _backViewOn = false;
          });
          Get.back();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jump Squadio',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: Get.locale,
      translations: Messages(),
      defaultTransition: Transition.fadeIn,
      fallbackLocale: Messages.fallbackLocale,
      supportedLocales: Messages.supportedLocales,
      builder: (context, child) {
        child = MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: botToastBuilder(context, child),
        );
        ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget),
          breakpoints: const [
            ResponsiveBreakpoint.resize(350, name: MOBILE),
            ResponsiveBreakpoint.autoScale(600, name: TABLET),
            ResponsiveBreakpoint.resize(800, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ],
        );
        return child;
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
