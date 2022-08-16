import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:g_f_m_login_firebase/components/curved-left-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-left.dart';
import 'package:g_f_m_login_firebase/components/curved-right-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-right.dart';
import 'package:g_f_m_login_firebase/modules/login/login_screen/login_screen.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/mobile_login/mobile_login_controller/mobile_login_controller.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/custom_button.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class OtpVerify extends StatelessWidget {
  OtpVerify({Key? key}) : super(key: key);
  String verificationId = Get.arguments[0];
  String contact = Get.arguments[1];

  MobileLoginController mobileLoginController =
      Get.put(MobileLoginController());
  @override
  Widget build(BuildContext context) {
    log("screen-----------$verificationId");
    log("screen-----------$contact");
    return Scaffold(
      // backgroundColor: AppColors.auth,
      body: Obx(
        () => Stack(
          children: [
            Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
            Positioned(top: 0, left: 0, child: CurvedLeft()),
            Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
            Positioned(bottom: 0, left: 0, child: CurvedRight()),
            Positioned(top: 40, left: 0, child: backButton()),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(top: 14.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 1.h),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppString.verifyOtp,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.w, vertical: 2.h),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  OtpTextField(
                                    numberOfFields: 6,
                                    borderColor: AppColors.otpVerify,
                                    //set to true to show as box or false to show as dash
                                    showFieldAsBox: true,
                                    //runs when a code is typed in
                                    onCodeChanged: (String code) {
                                      log("code----------$code");
                                      //handle validation or checks here
                                    },
                                    autoFocus: true,

                                    //runs when every textfield is filled
                                    onSubmit:
                                        (String verificationCode) {
                                      log("verificationCode-------$verificationCode");
                                      mobileLoginController.otp
                                          .value = verificationCode;
                                    }, // end onSubmit
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                          AppString.didntGetOtp),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: mobileLoginController
                                                  .isEnabled.value
                                              ? resendCode
                                              : null,
                                          child: mobileLoginController
                                                  .isEnabled.value
                                              ? Text(
                                                  AppString.sendAgain,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight
                                                              .bold,
                                                      fontSize:
                                                          13.sp),
                                                )
                                              : Text(
                                                  "${mobileLoginController.counter.value}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight
                                                              .bold,
                                                      fontSize:
                                                          13.sp),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                    width: double.infinity,
                                    child: CustomButton(
                                      onPressed: () {
                                        verifyOTP();
                                      },
                                      // style: ButtonStyle(
                                      //   backgroundColor:
                                      //       MaterialStateProperty.all(
                                      //           AppColors
                                      //               .buttonColor),
                                      //   padding:
                                      //       MaterialStateProperty.all(
                                      //     EdgeInsets.symmetric(
                                      //         vertical: 2.h),
                                      //   ),
                                      //   shape:
                                      //       MaterialStateProperty.all<
                                      //           RoundedRectangleBorder>(
                                      //     RoundedRectangleBorder(
                                      //       borderRadius:
                                      //           BorderRadius.circular(
                                      //               18.0),
                                      //     ),
                                      //   ),
                                      // ),
                                      child: const Text(
                                          AppString.submit),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () =>   Get.to(LogIn()),
                                        child: const Text(
                                          AppString.backToLogin,
                                          style: TextStyle(
                                              color: AppColors
                                                  .buttonColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 23.h,
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 5.h,
            //   child: SizedBox(
            //     height: 30.h,
            //     child: Padding(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
            //       child: Image(image: AssetImage(AppImages.login)),
            //     ),
            //   ),
            // ),
            mobileLoginController.verifyOtp.value
                ? Container(
                    height: 100.h,
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child:
                            Lottie.asset('assets/lottie/lottie.json'),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void verifyOTP() async {
    log("otp---${mobileLoginController.otp.value.trim()}");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: mobileLoginController.otp.value.trim());

    try {
      mobileLoginController.verifyOtp.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Get.toNamed(Routes.home);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        getSnackBar("Incorrect OTP", "Please enter correct otp",
            Colors.red.shade500, 3);

        log('Wrong OTP.');
      } else {
        Get.toNamed(Routes.mobileScreen);
        getSnackBar(
            "Some error accrues", "Please try again", Colors.red.shade500, 3);
        log("OtpVerify---->${e.code.toString()}");
      }
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("OtpVerify---->${e.toString()}");
    } finally {
      mobileLoginController.verifyOtp.value = false;
    }
  }

  void resendCode() {
    mobileLoginController.mobileLogin(contact: contact);
    getSnackBar("OTP Has Been Sent", "Please Check Your Inbox",
        Colors.green.shade600, 2);

    mobileLoginController.counter.value = 30;
    mobileLoginController.isEnabled.value = false;
  }
}
