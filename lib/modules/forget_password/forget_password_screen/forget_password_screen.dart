import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/components/curved-left-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-left.dart';
import 'package:g_f_m_login_firebase/components/curved-right-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-right.dart';
import 'package:g_f_m_login_firebase/modules/forget_password/forget_password_controller/forget_password_controller.dart';
import 'package:g_f_m_login_firebase/modules/login/login_screen/login_screen.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/widget/custom_button.dart';
import 'package:g_f_m_login_firebase/widget/custom_textfield_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);

  void _handleButtonDisable() {
    isDisable.value =
        (forgetPasswordController.forgetPasswordEmail.text == "" ||
            forgetPasswordController.forgetPasswordEmail.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
            Positioned(top: 0, left: 0, child: CurvedLeft()),
            // Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
            // Positioned(bottom: 0, left: 0, child: CurvedRight()),
            Positioned(top: 40, left: 0, child: backButton()),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 1.h),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppString.forgetPassword,
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
                                  horizontal: 5.w, vertical: 2.h),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return ValueListenableBuilder(
                                      valueListenable: _test,
                                      builder: (context, bool value, _) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                              onChanged: (String data) {
                                                _handleButtonDisable();
                                              },
                                              textEditingController:
                                                  forgetPasswordController
                                                      .forgetPasswordEmail,
                                              titleText: AppString.email,
                                              textInputAction:
                                                  TextInputAction.done,
                                              hintText: AppString.yourEmailId,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                              width: double.infinity,
                                              child: ValueListenableBuilder(
                                                valueListenable: isDisable,
                                                builder:
                                                    (context, bool value, _) {
                                                  return CustomButton(
                                                    change: value,
                                                    child:
                                                        Text(AppString.submit),
                                                    onPressed: () {
                                                      forgetPasswordController
                                                          .resetPassword(
                                                              email: forgetPasswordController
                                                                  .forgetPasswordEmail
                                                                  .text
                                                                  .trim());
                                                      // Get.toNamed(Routes.login);
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
                                                    // child: Padding(
                                                    //   padding:  EdgeInsets.symmetric(
                                                    //       vertical: 2.h),
                                                    //   child: const Text(
                                                    //       AppString.submit
                                                  );
                                                },
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
                                                  onTap: () => Get.to(LogIn()),
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
                                            //   height: 28.h,
                                            // )
                                          ],
                                        );
                                      });
                                },
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
            //   top: 0,
            //   child: Container(
            //     color: Colors.red,
            //     height: 32.h,
            //     child: Image.asset(AppImages.faceBook),
            //   ),
            // ),
            forgetPasswordController.forgetPasswordLoading.value
                ? Container(
                    height: 100.h,
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child: Lottie.asset('assets/lottie/lottie.json'),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
