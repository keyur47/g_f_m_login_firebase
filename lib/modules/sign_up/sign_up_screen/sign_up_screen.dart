import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/components/curved-left-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-left.dart';
import 'package:g_f_m_login_firebase/components/curved-right-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-right.dart';
import 'package:g_f_m_login_firebase/modules/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/validation/email_validation.dart';
import 'package:g_f_m_login_firebase/widget/custom_button.dart';
import 'package:g_f_m_login_firebase/widget/custom_textfield_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  SignUpController signUpController = Get.put(SignUpController());
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);

  void _handleButtonDisable() {
    isDisable.value = (signUpController.signUpName.text == "" ||
            signUpController.signUpName.text.isEmpty) ||
        (signUpController.signUpEmail.text == "" ||
            signUpController.signUpEmail.text.isEmpty) ||
        (signUpController.signUpContactNo.text == "" ||
            signUpController.signUpContactNo.text.isEmpty) ||
        (signUpController.signUpPassword.text == "" ||
            signUpController.signUpPassword.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.auth,
      body: Obx(
        () => Stack(
          children: [
            Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
            Positioned(top: 0, left: 0, child: CurvedLeft()),
            // Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
            // Positioned(bottom: 0, left: 0, child: CurvedRight()),
            Positioned(top: 40, left: 0, child: backButton()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                                AppString.signUp,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: CustomTextField(
                                        onChanged: (String data) {
                                          _handleButtonDisable();
                                        },
                                        textEditingController:
                                            signUpController.signUpName,
                                        titleText: AppString.name,
                                        textInputAction: TextInputAction.next,
                                        hintText: AppString.yourName,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: CustomTextField(
                                        onChanged: (String data) {
                                          _handleButtonDisable();
                                        },
                                        textEditingController:
                                            signUpController.signUpEmail,
                                        validator: (value) =>
                                            validateEmail(value),
                                        titleText: AppString.email,
                                        textInputAction: TextInputAction.next,
                                        hintText: AppString.yourEmailId,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: CustomTextField(
                                        onChanged: (String data) {
                                          _handleButtonDisable();
                                        },
                                        textEditingController:
                                            signUpController.signUpContactNo,
                                        titleText: AppString.contactNo,
                                        textInputAction: TextInputAction.next,
                                        hintText: AppString.yourContactNumber,
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: CustomTextField(
                                        onChanged: (String data) {
                                          _handleButtonDisable();
                                        },
                                        textEditingController:
                                            signUpController.signUpPassword,
                                        titleText: AppString.password,
                                        textInputAction: TextInputAction.done,
                                        hintText: AppString.password,
                                        keyboardType: TextInputType.text,
                                        obscure: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 1.6.h),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ValueListenableBuilder(
                                      valueListenable: isDisable,
                                      builder: (context, bool value, _) {
                                        return CustomButton(
                                          change: value,
                                          onPressed: () async {
                                            await signUpController
                                                .registerUsingEmailPassword(
                                              name: signUpController
                                                  .signUpName.text,
                                              contact: signUpController
                                                  .signUpContactNo.text,
                                              email: signUpController
                                                  .signUpEmail.text
                                                  .trim(),
                                              password: signUpController
                                                  .signUpPassword.text
                                                  .trim(),
                                            );
                                          },
                                          child: const Text(AppString.signup),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                )
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
            // Positioned(
            //   top: 0,
            //   child: Container(
            //       color: Colors.red,
            //       height: 32.h,
            //       child: Image.asset(AppImages.faceBook)),
            // ),
            signUpController.signUpLoading.value
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
