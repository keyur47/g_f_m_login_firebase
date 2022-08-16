import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/main.dart';
import 'package:g_f_m_login_firebase/modules/home/home_controller/home_controller.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/facebook_login/facebook_login.dart';
import 'package:g_f_m_login_firebase/modules/login/login_with_google_mobile_facebook/gmail_login/gmail_login.dart';
import 'package:g_f_m_login_firebase/modules/user_details/demo.dart';
import 'package:g_f_m_login_firebase/utils/app_assets.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 19.5.h,
                  child: Stack(
                    children: [
                      Container(
                        height: 15.h,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.userDetails);
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black54,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: FirebaseAuth
                                            .instance.currentUser!.photoURL
                                            .toString() ==
                                        'null'
                                    ? Image.asset(
                                        AppImages.profile,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        FirebaseAuth
                                            .instance.currentUser!.photoURL
                                            .toString(),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ScaleTransitionExample());
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    child: Row(
                      children: [
                        const Icon(Icons.star),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          AppString.rateUs,
                          style: TextStyle(fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    sp = await SharedPreferences.getInstance();
                    isUserLogin = sp.setBool('login', false);
                    log('spout-----${sp.getBool('login')}');
                    for (final providerProfile
                        in FirebaseAuth.instance.currentUser!.providerData) {
                      // ID of the provider (google.com, apple.cpm, etc.)
                      final provider = providerProfile.providerId;
                      try {
                        homeController.logOutLoading.value = true;
                        if (provider == 'google.com') {
                          log("logout with google");
                          FirebaseService service = FirebaseService();
                          await service.signOutFromGoogle();
                        } else if (provider == 'facebook.com') {
                          log("logout with facebook");
                          await signOutFromFacebook();
                        } else {
                          log("logout with other");
                          homeController.logOut();
                        }
                      } on FirebaseAuthException catch (e) {
                        log("----SignOut------${e.toString()}");
                        getSnackBar("Some error accrues", "Please try again",
                            Colors.red.shade500, 3);
                      } catch (e) {
                        getSnackBar("Some error accrues", "Please try again",
                            Colors.red.shade500, 3);

                        log("drawerLogOut---->${e.toString()}");
                      } finally {
                        homeController.logOutLoading.value = false;
                      }
                    }
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    child: Row(
                      children: [
                        const Icon(Icons.logout_rounded),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          AppString.logOut,
                          style: TextStyle(fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            homeController.logOutLoading.value
                ? Container(
                    height: 100.h,
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
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
