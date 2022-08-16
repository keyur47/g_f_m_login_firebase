import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/components/curved-left-shadow.dart';
import 'package:g_f_m_login_firebase/components/curved-left.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/mobile_login/mobile_login_controller/mobile_login_controller.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/custom_button.dart';
import 'package:g_f_m_login_firebase/widget/custom_textfield_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class MobileLogin extends StatelessWidget {
  MobileLogin({Key? key}) : super(key: key);
  MobileLoginController mobileLoginController =
      Get.put(MobileLoginController());
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);

  void _handleButtonDisable() {
    isDisable.value = (mobileLoginController.contactNumber.text == "" ||
        mobileLoginController.contactNumber.text.isEmpty);
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
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 1.h),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppString.logInWithPhone,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    onChanged: (String data){
                                      _handleButtonDisable();
                                    },
                                    textEditingController:
                                        mobileLoginController.contactNumber,
                                    titleText: AppString.contactNo,
                                    textInputAction: TextInputAction.done,
                                    hintText: AppString.yourContactNumber,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                    width: double.infinity,
                                    child: ValueListenableBuilder(
                                      valueListenable: isDisable,
                                      builder: (context, bool value, _) {
                                        return CustomButton(
                                          change: value,
                                          onPressed: () {
                                            mobileLoginController.mobileLogin(
                                                contact:
                                                    "+91${mobileLoginController.contactNumber.text.trim()}");
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
                                            AppString.getOtp,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.toNamed(Routes.login),
                                        child: const Text(
                                          AppString.backToLogin,
                                          style: TextStyle(
                                              color: AppColors.buttonColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 20.h,
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
            mobileLoginController.mobileLoading.value
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
