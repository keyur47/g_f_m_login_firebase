import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/modules/home/home_controller/home_controller.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/app_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  DateTime data = DateTime.now();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        for (final providerProfile
            in FirebaseAuth.instance.currentUser!.providerData) {
          // ID of the provider (google.com, apple.cpm, etc.)
          final provider = providerProfile.providerId;
          log("provider---${provider.toString()}");

          // UID specific to the provider
          final uid = providerProfile.uid;
          log("uid---${uid.toString()}");

          // Name, email address, and profile photo URL
          final name = providerProfile.displayName;
          final emailAddress = providerProfile.email;
          final profilePhoto = providerProfile.photoURL;
          final contact = providerProfile.phoneNumber;
          log("name---${name.toString()}");
          log("emailAddress---${emailAddress.toString()}");
          log("photoUrl---${profilePhoto.toString()}");
          log("contact---${contact.toString()}");
        }
        log("homeScreen----Login");
      } else {
        log("homeScreen----logout");
        log("message---${FirebaseAuth.instance.currentUser?.uid.toString()}");
      }
    });

    return Scaffold(
      appBar: AppBar(
        title:  Text(AppString.home),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
        actions: [
          Obx(
            () => homeController.longPress.value
                ? IconButton(
                    onPressed: () {
                      if (homeController.isAllAdded.value == false) {
                        for (var e in homeController.allData) {
                          homeController.selectedItems.add(e.docId);
                          homeController.isAllAdded.value = true;
                        }
                      } else {
                        homeController.selectedItems.clear();
                        homeController.isAllAdded.value = false;
                        //homeController.longPress.value = false;
                      }
                      log("allSelectButton--=---${homeController.selectedItems.toString()}");
                    },
                    tooltip: homeController.isAllAdded.value
                        ? AppString.removeAll
                        : AppString.selectAll,
                    icon: homeController.isAllAdded.value
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank),
                  )
                : const SizedBox(),
          ),
          Obx(
            () => homeController.longPress.value
                ? IconButton(
                    onPressed: () {
                      homeController.longPress.value = false;

                      log("Else=--${homeController.longPress.value}");
                      homeController.batchDelete();

                      homeController.selectedItems.clear();
                      log("Else=--${homeController.selectedItems}");
                      Get.snackbar(
                        "Record Delete",
                        "Record has been deleted successfully",
                        icon: const Icon(Icons.person, color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade400,
                        borderRadius: 20,
                        margin: const EdgeInsets.all(15),
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    },
                    icon: const Icon(Icons.delete),
                    tooltip: AppString.delete,
                  )
                : const SizedBox(),
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: AppString.addNote,
        onPressed: () {
          Get.toNamed(Routes.addNew);
        },
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.add),
      ),
      body: WillPopScope(
        onWillPop: () {
          homeController.selectedItems.clear();
          homeController.isAllAdded.value = false;
          homeController.longPress.value = false;

          return Future(() => false);
        },
        child: Obx(
          () => Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                child: GridView.builder(
                  itemCount: homeController.allData.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 25.h,
                    maxCrossAxisExtent: 25.h,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (_, index) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        if (homeController.longPress.value == true) {
                          if (!homeController.selectedItems.contains(
                              homeController.allData[index].docId.toString())) {
                            homeController.selectedItems.add(
                              homeController.allData[index].docId.toString(),
                            );
                            log('addToList-->${homeController.selectedItems}');
                          } else if (homeController.selectedItems.contains(
                              homeController.allData[index].docId.toString())) {
                            homeController.selectedItems.removeWhere(
                              (val) =>
                                  val ==
                                  homeController.allData[index].docId
                                      .toString(),
                            );
                            log('removeFromList-->${homeController.selectedItems}');

                            if (homeController.selectedItems.isEmpty) {
                              homeController.longPress.value = false;
                              log('==emptyList--longPressValue--${homeController.longPress.value}');
                              log('emptyList--${homeController.selectedItems}');
                            }
                          }
                        } else {
                          Get.toNamed(
                            Routes.addNew,
                            arguments: homeController.allData[index],
                          );
                        }
                      },
                      onLongPress: () {
                        homeController.longPress.value = true;
                        if (!homeController.selectedItems.contains(
                            homeController.allData[index].docId.toString())) {
                          homeController.selectedItems.add(
                            homeController.allData[index].docId.toString(),
                          );
                        }
                        log('---${homeController.longPress.value}');
                        log('list-->${homeController.selectedItems}');
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Obx(()=>
                                   Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      homeController.allData[index].description
                                          .toString(),
                                      softWrap: true,
                                      maxLines: 8,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Positioned(
                                    top: 10,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                homeController.longPress.value
                                                    ? AppColors.black
                                                    : Colors.transparent),
                                        borderRadius: BorderRadius.circular(50),
                                        color: (homeController.selectedItems
                                                .contains(homeController
                                                    .allData[index].docId
                                                    .toString()))
                                            ? AppColors.buttonColor
                                            : Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.done_outlined,
                                          size: 15,
                                          color: (homeController.selectedItems
                                                  .contains(homeController
                                                      .allData[index].docId
                                                      .toString()))
                                              ? AppColors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                homeController.allData[index].attachment
                                        .toString()
                                        .isNotEmpty
                                    ? Positioned(
                                        top: 10,
                                        right: 5,
                                        child: Icon(
                                          Icons.attach_file_rounded,
                                          size: 10.sp,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            homeController.allData[index].title
                                    .toString()
                                    .isNotEmpty
                                ? homeController.allData[index].title.toString()
                                : 'Text Note',
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.sp),
                          ),
                          Text(
                            dateTimeFormat(homeController.allData[index].time!
                                .toDate()
                                .toString()),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 11.sp),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Future<ui.Image> getImage(String path) async {
//   var completer = Completer<ImageInfo>();
//   var img = NetworkImage(path);
//   img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
//     completer.complete(info);
//   }));
//   ImageInfo imageInfo = await completer.future;
//   return imageInfo.image;
// }
}

dateTimeFormat(String date) {
  var dataaaa = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  final DateFormat formatter = DateFormat('M/dd');
  final String formatted = formatter.format(dataaaa);
  print("-----------$formatted");
  return formatted;
}
