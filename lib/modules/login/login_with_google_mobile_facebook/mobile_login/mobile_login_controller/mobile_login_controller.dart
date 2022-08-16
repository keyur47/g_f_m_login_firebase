import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';


class MobileLoginController extends GetxController {
  RxBool mobileLoading = false.obs;
  RxBool isEnabled = true.obs;
  RxInt counter = 30.obs;
  RxBool verifyOtp = false.obs;

  TextEditingController contactNumber = TextEditingController();
  RxString otp = ''.obs;

  @override
  void onInit() {
    ///time button
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (counter.value != 0) {
        counter.value--;
      } else {
        isEnabled.value = true;
      }
    });
    super.onInit();
  }

  ///SEND OTP
  Future<User?> mobileLogin({
    required String contact,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      mobileLoading.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: contact,
        codeSent: (verificationId, resendToken) {
          log("-vID--------------$verificationId");
          Get.toNamed(Routes.otpVerify, arguments: [verificationId, contact]);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 30),
        verificationFailed: (FirebaseAuthException error) {
          getSnackBar(
              "Some error accrues", "Please try again", Colors.red.shade500, 3);
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      );

      contactNumber.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        getSnackBar("Your account has been disabled",
            "Try with different account", Colors.red.shade500, 3);
        log('Disable Account.');
      } else {
        getSnackBar(
            "Some error accrues", "Please try again", Colors.red.shade500, 3);

        log("---Mobile-------${e.toString()}");
      }
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("MobileLogin---->${e.toString()}");
    } finally {
      mobileLoading.value = false;
    }
    return null;
  }
}
