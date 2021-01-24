import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:web_test/utilities/custom_alert_dialog.dart';
import 'package:web_test/utilities/custom_dialog.dart';
import 'package:web_test/utilities/custom_route.dart';

class ApplicationPlatform {
  static final ApplicationPlatform _shared =
  new ApplicationPlatform._internal();
  static ApplicationPlatform get shared => _shared;
  static bool get isIOS => _isWeb() ? false : Platform.isIOS;
  static bool get isAndroid => _isWeb() ? false : Platform.isAndroid;
  static bool get isWeb => _isWeb();
  static bool get isWindows => _isWeb() ? false : Platform.isWindows;
  static bool get isLinux => _isWeb() ? false : Platform.isLinux;
  static bool get isMacOS => _isWeb() ? false : Platform.isMacOS;
  factory ApplicationPlatform() {
    return _shared;
  }
  ApplicationPlatform._internal();

  static bool _isWeb() {
    return kIsWeb;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final primaryColor = HexColor("3E64FF");

showCustomAlertDialog(
    BuildContext context,
    String title,
    String content, {
      String contract,
      CustomOptionDialog buttonLeft,
      CustomOptionDialog buttonRight,
      bool isRichText = false,
      String iconCenter,
      bool root = true,
      bool cancelable = true,
      bool noIcon = false,
    }) {
  return push(
      context,
      CustomDialog(
        screen: CustomAlertDialog(
          title: title,
          content: content,
          buttonLeft: buttonLeft,
          buttonRight: buttonRight,
          iconCenter: iconCenter,contract: contract,
          isRichText: isRichText,noIcon: noIcon,
        ),
        cancelable: cancelable,
      ),
      opaque: false,
      root: root);
}
push(BuildContext context, Widget screen,
    {bool root = true, bool opaque = true, bool isHero = false}) {
  // Navigator.of(context, rootNavigator: root).removeHUD();
  String name = "";
  if (screen.runtimeType.toString().contains("Screen")) {
    name = screen.runtimeType.toString().replaceAll('Screen', ' ') + "Screen";
  } else if (screen.runtimeType.toString().contains("Page")) {
    name = screen.runtimeType.toString().replaceAll('Page', ' ') + "Screen";
  } else {
    name = screen.runtimeType.toString() + "Screen";
  }
  return Navigator.of(context, rootNavigator: root)
      .push(CustomRoute(page: screen, opaque: opaque, isHero: isHero));
}
