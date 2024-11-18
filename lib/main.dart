import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/screens/mobile/splash_screen.dart';

import 'package:news_beeper/screens/web/web_splash_screen.dart';
import 'package:news_beeper/utils/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'News Beeper',
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Quicksand",
            splashFactory: NoSplash.splashFactory,
            colorScheme: const ColorScheme.light()),
        darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: "Quicksand",
            splashFactory: NoSplash.splashFactory,
            colorScheme: const ColorScheme.dark()),
        themeMode: getStorage.read(AppStrings.themeMode) == null ||
                getStorage.read(AppStrings.themeMode) != "dark"
            ? ThemeMode.light
            : ThemeMode.dark,
        home: kIsWeb ? WebSplashScreen() : SplashScreen());
  }
}
