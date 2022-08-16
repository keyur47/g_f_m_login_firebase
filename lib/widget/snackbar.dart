import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController getSnackBar(title, subtitle, backgroundColor, time) {
  return Get.snackbar(
    title,
    subtitle,
    icon: const Icon(Icons.person, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: time ?? 3),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
