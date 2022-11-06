import 'package:flutter/material.dart';

class DataConstants {
  static Color whiteColor = const Color(0xffffffffff);
  static Color blackColor = const Color(0xff000000FF);
  static Color greyColor = const Color(0xff242424FF);
  static Color blueColor = const Color(0xff13168EFF);
  static void showBasicToast({context,message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$message'),
    ),);
  }

}
