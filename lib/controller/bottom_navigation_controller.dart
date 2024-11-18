import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController{

  int index = 0;

  // Change bottom navigation
  void changeBottomNavigation({required int currentIndex}){
    index = currentIndex;
    update();
  }

}