import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/modules/add_new_note/add_new_note_controller/add_new_note_controller.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:g_f_m_login_firebase/utils/app_string.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/custom_textfield_view.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class AddNewNote extends StatelessWidget {
  AddNewNote({Key? key}) : super(key: key);

  AddNewNoteController addNewNoteController = Get.put(AddNewNoteController());

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    if (data != null) {
      addNewNoteController.docId = data.docId;
      addNewNoteController.titleText.text = data.title;
      addNewNoteController.descriptionText.text = data.description;
      log(data.attachment.toString());
      if (data.attachment.toString().isNotEmpty) {
        log("Hello");
        addNewNoteController.isFileGet.value = true;
        addNewNoteController.imagePath.value = data.attachment;
      } else {
        log("Not Hello");
        addNewNoteController.isFileGet.value = false;
        // addNewNoteController.imagePath.value = '';
      }
    }
    return Scaffold(
      appBar: AppBar(
        title:  const Text(AppString.note),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 13.sp,
          ),
          tooltip: AppString.back,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await addNewNoteController.getFromGallery();
            },
            icon: Icon(
              Icons.attach_file_rounded,
              size: 16.sp,
            ),
            tooltip: AppString.attachment,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (data != null) {
            addNewNoteController.updateNotes(
                addNewNoteController.docId,
                addNewNoteController.titleText.text,
                addNewNoteController.descriptionText.text,
                addNewNoteController.imagePath.isNotEmpty
                    ? addNewNoteController.imagePath.value
                    : '',
                addNewNoteController.dateTime);
            Get.offNamed(Routes.home);
          } else {
            if (addNewNoteController.titleText.text.isNotEmpty ||
                addNewNoteController.descriptionText.text.isNotEmpty) {
              addNewNoteController.addNotes(
                addNewNoteController.titleText.text,
                addNewNoteController.descriptionText.text,
                addNewNoteController.imagePath.value.isNotEmpty
                    ? addNewNoteController.imagePath.value
                    : '',
                addNewNoteController.dateTime,
              );
              Get.offNamed(Routes.home);
            } else if (addNewNoteController.titleText.text.isEmpty ||
                addNewNoteController.descriptionText.text.isEmpty) {
              Get.snackbar('Add some input',
                  'Both title and description can not be empty',
                  duration: const Duration(seconds: 2),
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.symmetric(vertical: 2.h));
            }
          }
        },
        tooltip: AppString.add,
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.done),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: ListView(
            children: [
              CustomTextField(
                titleText: AppString.title,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hintText: AppString.title,
                textEditingController: addNewNoteController.titleText,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                AppString.description,
                style: TextStyle(fontSize: 15.sp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Container(
                  // constraints: const BoxConstraints(
                  //     maxHeight: double.maxFinite,
                  //     maxWidth: double.maxFinite,
                  //     minHeight: 100,
                  //     minWidth: 100),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    // minHeight: 20.h,
                    maxHeight: 70.h,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Obx(
                      () => Column(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              controller: addNewNoteController.descriptionText,
                              style: TextStyle(fontSize: 12.sp),
                              textCapitalization: TextCapitalization.sentences,
                              cursorColor: AppColors.black,
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: AppString.description,
                              ),
                            ),
                          ),
                          Container(
                            child: addNewNoteController.isFileGet.value &&
                                    addNewNoteController.imagePath.value != ''
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(Routes.imageView,
                                                  arguments:
                                                      addNewNoteController
                                                          .imagePath.value);
                                            },
                                            child: Hero(
                                              tag: 'imageHero',
                                              child: Image.file(
                                                File(addNewNoteController
                                                    .imagePath
                                                    .toString()),
                                                height: 20.h,
                                              ),
                                            ),
                                          ),
                                          // Obx(
                                          //   () => Expanded(
                                          //     child: Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child: GridView.builder(
                                          //         gridDelegate:
                                          //             const SliverGridDelegateWithFixedCrossAxisCount(
                                          //                 crossAxisCount: 2,
                                          //                 crossAxisSpacing: 4.0,
                                          //                 mainAxisSpacing: 4.0),
                                          //         itemCount:
                                          //             addNewNoteController
                                          //                 .imagePath.length,
                                          //         itemBuilder:
                                          //             (BuildContext context,
                                          //                 int index) {
                                          //           return Column(
                                          //             children: [
                                          //               Stack(
                                          //                 children: [
                                          //                   GestureDetector(
                                          //                     child: Hero(
                                          //                       tag:
                                          //                           'imageHero$index',
                                          //                       child: SizedBox(
                                          //                         height: 20.h,
                                          //                         width: 50.w,
                                          //                         child: Image
                                          //                             .file(
                                          //                           addNewNoteController
                                          //                                   .imagePath[
                                          //                               index],
                                          //                           fit: BoxFit
                                          //                               .cover,
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                     onTap: () {
                                          //                       // Get.toNamed(Routes.viewImage,
                                          //                       //     arguments: imageController
                                          //                       //         .imagePath[index].path);
                                          //
                                          //                       //for print image extension
                                          //                       log(addNewNoteController
                                          //                           .imagePath[
                                          //                               index]
                                          //                           .path
                                          //                           .split('.')
                                          //                           .last);
                                          //                     },
                                          //                   ),
                                          //                   Positioned(
                                          //                     top: 5,
                                          //                     right: 5,
                                          //                     child:
                                          //                         GestureDetector(
                                          //                       onTap: () {
                                          //                         addNewNoteController
                                          //                             .imagePath
                                          //                             .removeAt(
                                          //                                 index);
                                          //                         addNewNoteController
                                          //                             .imageName
                                          //                             .removeAt(
                                          //                                 index);
                                          //                       },
                                          //                       child:
                                          //                           const CircleAvatar(
                                          //                         radius: 10,
                                          //                         backgroundColor:
                                          //                             Colors
                                          //                                 .white30,
                                          //                         child: Icon(
                                          //                           Icons.clear,
                                          //                           size: 15,
                                          //                           color: Colors
                                          //                               .black,
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //               Text(
                                          //                 addNewNoteController
                                          //                     .imageName[index]
                                          //                     .path
                                          //                     .toString()
                                          //                     .split('.')
                                          //                     .first,
                                          //                 maxLines: 1,
                                          //               )
                                          //             ],
                                          //           );
                                          //         },
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              // onTap: () {
                                              //   addNewNoteController
                                              //       .imagePath.value = '';
                                              //   addNewNoteController
                                              //       .imageName.value = '';
                                              // },
                                              child: const CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.white30,
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
