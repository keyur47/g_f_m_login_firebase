// Future<Resource?> signInWithFacebook() async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login();
//     switch (result.status) {
//       case LoginStatus.success:
//         final AuthCredential facebookCredential =
//         FacebookAuthProvider.credential(result.accessToken!.token);
//         final userCredential =
//         await _auth.signInWithCredential(facebookCredential);
//         return Resource(status: Status.Success);
//       case LoginStatus.cancelled:
//         return Resource(status: Status.Cancelled);
//       case LoginStatus.failed:
//         return Resource(status: Status.Error);
//       default:
//         return null;
//     }
//   } on FirebaseAuthException catch (e) {
//     throw e;
//   }
// }

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:g_f_m_login_firebase/modules/login/log_in_controller/log_in_controller.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';

LogInController logInController = Get.put(LogInController());
Future<User?> signInWithFacebook() async {
  User? user;
  try {
    logInController.facebookLoading.value = true;
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);

    switch (result.status) {
      case LoginStatus.success:
        try {
          await loginWithFacebook(result);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-disabled') {
            getSnackBar("Your account has been disabled",
                "Try with different account", Colors.red.shade500, 3);
            log('Disable Account.');
          } else {
            getSnackBar("Some error accrues", "Please try again",
                Colors.red.shade500, 3);

            log("FB--->>${e.toString()}");
          }
        }
        break;
      case LoginStatus.cancelled:
        log("FB->status cancelled");
        break;
      case LoginStatus.failed:
        log("FB->status failed");
        break;
      case LoginStatus.operationInProgress:
        break;
    }
  } catch (e) {
    getSnackBar(
        "Some error accrues", "Please try again", Colors.red.shade500, 3);

    log("faceBookLogin---->${e.toString()}");
  } finally {
    logInController.facebookLoading.value = false;
  }

  return user;
}

Future loginWithFacebook(LoginResult result) async {
  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken!.token);

  log("FbTOKEN->${result.accessToken!.token.toString()}");

  await FacebookAuth.instance.getUserData();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      Get.toNamed(Routes.home);

      log("FB----Login");
    }
  });

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

Future<void> signOutFromFacebook() async {
  await FacebookAuth.instance.logOut();
  await FirebaseAuth.instance.signOut();
  Get.toNamed(Routes.login);
  log("logout------- with facebook");
}
