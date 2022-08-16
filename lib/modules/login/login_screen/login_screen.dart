import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_f_m_login_firebase/components/curved-left-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-left.dart';
import 'package:g_f_m_login_firebase/modules/forget_password/forget_password_screen/forget_password_screen.dart';
import 'package:g_f_m_login_firebase/modules/login/log_in_controller/log_in_controller.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/facebook_login/facebook_login.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/gmail_login/gmail_login.dart';
import 'package:g_f_m_login_firebase/utils/app_assets.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/custom_button.dart';
import 'package:g_f_m_login_firebase/widget/custom_textfield_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  LogInController logInController = Get.put(LogInController());
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);

  void _handleButtonDisable() {
    isDisable.value = (logInController.logInEmail.text == "" ||
            logInController.logInEmail.text.isEmpty) ||
        (logInController.logInPassword.text == "" ||
            logInController.logInPassword.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      log("---------${FirebaseAuth.instance.currentUser?.uid.toString()}");
      log("---------Logged in");
    } else {
      log("------------out");
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
          Positioned(top: 0, left: 0, child: CurvedLeft()),
          // Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
          // Positioned(bottom: 0, left: 0, child: CurvedRight()),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppString.logIn,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30.sp,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return ValueListenableBuilder(
                                  valueListenable: _test,
                                  builder: (context, bool value, _) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          child: CustomTextField(
                                            textEditingController:
                                                logInController.logInEmail,
                                            titleText: AppString.email,
                                            textInputAction:
                                                TextInputAction.next,
                                            hintText: AppString.yourEmailId,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (String data) {
                                              _handleButtonDisable();
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          child: CustomTextField(
                                            onChanged: (String data) {
                                              _handleButtonDisable();
                                            },
                                            textEditingController:
                                                logInController.logInPassword,
                                            titleText: AppString.password,
                                            textInputAction:
                                                TextInputAction.done,
                                            hintText: AppString.password,
                                            keyboardType: TextInputType.text,
                                            obscure:
                                                logInController.isObscure.value,
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                logInController
                                                        .isObscure.value =
                                                    !logInController
                                                        .isObscure.value;
                                                log("${logInController.isObscure.value}");
                                              },
                                              child: logInController
                                                      .isObscure.value
                                                  ? const Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      color: Colors.grey,
                                                    )
                                                  : const Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.grey,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                          onTap: () => Get.to(ForgetPassword()),
                                          child: const Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                                AppString.forgetPassword +
                                                    AppString.questionMark),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ValueListenableBuilder(
                                            valueListenable: isDisable,
                                            builder: (context, bool value, _) {
                                              return CustomButton(
                                                change: value,
                                                onPressed: () async {
                                                  await logInController
                                                      .signInUsingEmailPassword(
                                                          email: logInController
                                                              .logInEmail.text
                                                              .trim(),
                                                          password:
                                                              logInController
                                                                  .logInPassword
                                                                  .text
                                                                  .trim());
                                                },
                                                child:
                                                    const Text(AppString.login),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "${AppString.dontHaveAnAccount} "),
                                            const Text(
                                                "${AppString.questionMark} "),
                                            GestureDetector(
                                              onTap: () =>
                                                  Get.toNamed(Routes.signUp),
                                              child: const Text(
                                                AppString.signup,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.buttonColor),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              child: Divider(
                                                thickness: 1.5,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            const Text(AppString.orLoginWith),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            const Expanded(
                                              child: Divider(
                                                thickness: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  FirebaseService service =
                                                      FirebaseService();
                                                  await service
                                                      .signInWithGoogle();
                                                },
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          5),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColors.white),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const CircleBorder(),
                                                  ),
                                                ),
                                                child: SvgPicture.asset(
                                                    AppImages.google),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      Routes.mobileScreen);
                                                },
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          5),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColors.white),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const CircleBorder(),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.phone_android,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  signInWithFacebook();
                                                },
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          5),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppColors.white),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const CircleBorder(),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                      AppImages.faceBook),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                      ],
                                    );
                                  });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
