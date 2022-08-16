import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_f_m_login_firebase/modules/login/login_screen/login_screen.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
late SharedPreferences sp;
var isUserLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}
initSp() async {
  sp = await SharedPreferences.getInstance();
  isUserLogin = sp.getBool('login');
  log('mainSPValue-----${sp.getBool('login')}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: isUserLogin == true ? Routes.home : Routes.login,
        getPages: Routes.route,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LogIn(),
      );
    });
  }
}
