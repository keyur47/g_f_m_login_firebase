import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/modules/login/log_in_controller/log_in_controller.dart';
import 'package:g_f_m_login_firebase/modules/login/login_screen/login_screen.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


LogInController logInController = Get.put(LogInController());

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    try {
      logInController.gmailLoading.value = true;
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Get.toNamed(Routes.home);
        }
      });
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        getSnackBar("Your account has been disabled",
            "Try with different account", Colors.red.shade500, 3);
        log('Disable Account.');
      } else {
        getSnackBar(
            "Some error accrues", "Please try again", Colors.red.shade500, 3);

        log("GmailLogin--->${e.toString()}");
      }
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("gmailLogin---->${e.toString()}");
    } finally {
      logInController.gmailLoading.value = false;
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Get.toNamed(Routes.login);
    log("logout------- with google");
  }
}
