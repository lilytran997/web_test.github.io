import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_test/common/constant.dart';
import 'package:web_test/utilities/responsive.dart';

class Globals{
  static double maxWidth;
  static double maxHeight;
  static double maxPadding;
  static double minPadding;
  static double statusBarHeight;
  static double ratio;
  static SharedPreferences prefs;
  static double tabbarSize;

  static String fullName = "";
  static String idNumber = "";
  static ApplicationMode _applicationMode;

  init({BuildContext context, ApplicationMode model}){
   if(context!=null){
     maxWidth = MediaQuery.of(context).size.width;
     maxHeight = MediaQuery.of(context).size.height;
     ratio = maxHeight / maxWidth;
     statusBarHeight = MediaQuery.of(context).padding.top;
     if(ResponsiveWidget.isSmallScreen(context)){
       if(ResponsiveWidget.isLargerWidth(context)){
         maxPadding = maxHeight * 0.05;
         minPadding = maxPadding / 2;
         tabbarSize = maxHeight / 10 * 7;
       }else{
         maxPadding = maxWidth * 0.05;
         minPadding = maxPadding / 2;
         tabbarSize = maxWidth / 10 * 7;
       }
     }else if(ResponsiveWidget.isMediumScreen(context)){
       maxPadding = maxHeight * 0.05;
       minPadding = maxPadding / 2;
       tabbarSize = maxHeight / 10 * 7;
     }else{
       maxPadding = maxHeight * 0.05;
       minPadding = maxPadding / 2;
       tabbarSize = maxHeight / 10 * 7;
     }
   }
   if(model!=null){
     _applicationMode = model;
   }
    SharedPreferences.getInstance().then((event) => prefs = event);
  }
  static bool checkUserId(String idNumber) {
    if( prefs != null){
      String point = prefs.getString(userIdKey + idNumber) ?? "";
      return point == "" ? false : true;
    }
    return false;
  }

  static saveDoneId(String point) async {
    if( prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
    prefs.setString((userIdKey + idNumber), point);
  }

}
enum ApplicationMode { PRODUCTION, STAGING, DEVELOPMENT }