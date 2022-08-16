import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewNoteController extends GetxController {
  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();

  ImagePicker pick = ImagePicker();
  XFile? image;
  RxString imagePath = ''.obs;
  RxString imageName = ''.obs;
  RxBool isFileGet = false.obs;

  DateTime dateTime = DateTime.now();
  var docId = '';

  ///Add to Cloud Firebase
  Future<void> addNotes(title, description, attachment, dateTime) async {
    var uniqueKey = FirebaseFirestore.instance.collection("Notes").doc();

    await FirebaseFirestore.instance.collection("Notes").doc(uniqueKey.id).set({
      'documentId': uniqueKey.id,
      'title': title,
      'description': description,
      'time': dateTime,
      'attachment': attachment,
      'userId': FirebaseAuth.instance.currentUser?.uid.toString()
    });
  }

  ///Update data to Cloud Firebase
  Future<void> updateNotes(
      String id, title, description, attachment, dateTime) async {
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'time': dateTime,
      'attachment': attachment
    };

    await FirebaseFirestore.instance.collection("Notes").doc(id).update(data);
  }

  ///ImagePicker
  getFromGallery() async {
    try {
      isFileGet.value = false;

      var image = await pick.pickImage(source: ImageSource.gallery);
      if (image != null) {
        image = image;

        // for (var e in image) {
        //   imagePath1.add(File(e.path));
        //   imageName1.add(File(e.name));
        // }
        // for (var e in imagePath1) {
        //   log("megeP-->${e.length}");
        //   log("megeN-->${e}");
        // }
        log("IMAge---->$image");
        //for single image
        imageName.value = image.name;
        imagePath.value = image.path;
        log("imagePickerPath--------------${imagePath.value}");
        log("imagePickerName--------------${imageName.value}");
        log("----XFilePath----------${image.path}");
        update();

        log("IMAgf55e---->${image.toString()}");
        log("mes-->${imagePath.toString()}");
        isFileGet.value = true;
      } else {
        log('No image selected.');
        isFileGet.value = false;
      }
    } catch (e) {
      //isFileGet.value = false;
      log("imagePickerError--->${e.toString()}");
    }
  }
}
