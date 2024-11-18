import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/utils/app_strings.dart';

class ThemeController extends GetxController{

  final getStorage = GetStorage();

  // Change theme
  void changeThemeMode(){
    String? theme = getStorage.read(AppStrings.themeMode);
    if(theme == null || theme == "dark"){
      getStorage.write(AppStrings.themeMode, "light");
      Get.changeThemeMode(ThemeMode.light);
    }else{
      getStorage.write(AppStrings.themeMode, "dark");
      Get.changeThemeMode(ThemeMode.dark);
    }
    update();
  }

  // Change icon according to theme
  IconData iconTheme(){
    String? theme = getStorage.read(AppStrings.themeMode);
    if(theme == "light" || theme == null){
      return Icons.dark_mode;
    }else{
      return Icons.light_mode;
    }
  }

}