import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  RxBool logInLoading = false.obs;
  RxBool isObscure = true.obs;
  RxBool gmailLoading = false.obs;
  RxBool facebookLoading = false.obs;

  GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

  TextEditingController logInEmail = TextEditingController();
  TextEditingController logInPassword = TextEditingController();

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    logInLoading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      log(user!.uid);
      logInEmail.clear();
      logInPassword.clear();
      Get.toNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        getSnackBar("User not found", "Try with different account",
            Colors.red.shade500, 3);

        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        getSnackBar(
            "Password does not match",
            "Try with different password OR use Forget password",
            Colors.red.shade500,
            3);

        log('Wrong password provided.');
      } else if (e.code == 'user-disabled') {
        getSnackBar("Your account has been disabled",
            "Try with different account", Colors.red.shade500, 3);

        log('Disable Account.');
      } else {
        getSnackBar(
            "Some error accrues", "Please try again", Colors.red.shade500, 3);

        log("loginWithEmail--->${e.toString()}");
      }
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("LogIn---->${e.toString()}");
    } finally {
      logInLoading.value = false;
    }
    return user;
  }
}
