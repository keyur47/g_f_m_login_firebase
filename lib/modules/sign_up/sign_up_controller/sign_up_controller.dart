import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool signUpLoading = false.obs;

  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpContactNo = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();

  Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String contact,
    required String password,
  }) async {
    signUpLoading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      Get.toNamed(Routes.login);

      signUpName.clear();
      signUpEmail.clear();
      signUpContactNo.clear();
      signUpPassword.clear();

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Get.offNamed(Routes.home);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        getSnackBar("User already exist", "Try with different account",
            Colors.red.shade500, 3);
        log('The account already exists for that email.');
      } else if (e.code == 'user-disabled') {
        getSnackBar("Your account has been disabled",
            "Try with different account", Colors.red.shade500, 3);

        log('Disable Account.');
      } else {
        getSnackBar(
            "Some error accrues", "Please try again", Colors.red.shade500, 3);

        log("signUp---->${e.toString()}");
      }
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("signUp---->${e.toString()}");
    } finally {
      signUpLoading.value = false;
    }
    return user;
  }
}
