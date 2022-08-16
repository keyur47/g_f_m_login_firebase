import 'package:g_f_m_login_firebase/modules/add_new_note/add_new_note_screen/add_new_note.dart';
import 'package:g_f_m_login_firebase/modules/forget_password/forget_password_screen/forget_password_screen.dart';
import 'package:g_f_m_login_firebase/modules/home/home_screen/home_screen.dart';
import 'package:g_f_m_login_firebase/modules/image_view/image_view_screeen/image_view.dart';
import 'package:g_f_m_login_firebase/modules/login/login_screen/login_screen.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/mobile_login/screens/mobile_login_screen.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/mobile_login/screens/otp_verify_set_password.dart';
import 'package:g_f_m_login_firebase/modules/sign_up/sign_up_screen/sign_up_screen.dart';
import 'package:g_f_m_login_firebase/modules/user_details/user_details.dart';
import 'package:get/get.dart';

Transition defaultTransitions = Transition.native;
Transition fade = Transition.fadeIn;

class Routes {
  static const login = '/logIn';
  static const signUp = '/signUp';
  static const forgetPassword = '/forgetPassword';
  static const home = '/home';
  static const addNew = '/addNew';
  static const apiCalling = '/apiCalling';
  static const studentScreen = '/studentScreen';
  static const mobileScreen = '/mobileScreen';
  static const otpVerify = '/otpVerify';
  static const userDetails = '/userDetails';
  static const imageView = '/imageView';

  static final route = [
    GetPage(name: login, page: () => LogIn(), transition: defaultTransitions),
    GetPage(name: signUp, page: () => SignUp(), transition: defaultTransitions),
    GetPage(
        name: forgetPassword,
        page: () => ForgetPassword(),
        transition: defaultTransitions),
    GetPage(name: home, page: () => Home(), transition: defaultTransitions),
    GetPage(
        name: addNew, page: () => AddNewNote(), transition: defaultTransitions),
    GetPage(
        name: mobileScreen,
        page: () => MobileLogin(),
        transition: defaultTransitions),
    GetPage(
        name: otpVerify,
        page: () => OtpVerify(),
        transition: defaultTransitions),
    GetPage(
        name: userDetails,
        page: () => UserDetails(),
        transition: defaultTransitions),
    GetPage(name: imageView, page: () => ImageView(), transition: fade),
  ];
}
