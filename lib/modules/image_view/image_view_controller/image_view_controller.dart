import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImageViewController extends GetxController {
  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }
}
