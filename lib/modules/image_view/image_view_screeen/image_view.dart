import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:get/get.dart';

class ImageView extends StatelessWidget {
  ImageView({Key? key}) : super(key: key);

  //ImageViewController imageViewController = Get.put(ImageViewController());
  var imageArg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      // appBar: AppBar(
      //   backgroundColor: AppColors.black,
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       size: 13.sp,
      //     ),
      //     tooltip: AppString.back,
      //   ),
      // ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: Image.file(File(imageArg)),
        ),
      ),
    );
  }
}
