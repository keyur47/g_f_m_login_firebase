import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/main.dart';
import 'package:g_f_m_login_firebase/modules/home/data_model/home_model.dart';
import 'package:g_f_m_login_firebase/utils/navigation_utils/navigation.dart';
import 'package:g_f_m_login_firebase/widget/snackbar.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxList<NotesModel> allData = <NotesModel>[].obs;
  RxBool logOutLoading = false.obs;
  RxBool longPress = false.obs;
  RxBool isAllAdded = false.obs;
  RxList selectedItems = [].obs;

  @override
  onInit() {
    super.onInit();
    allData.bindStream(getNoteData());
    isUserLoggedIn();
  }

  ///Check if user logged in or not
  Future<void> isUserLoggedIn() async {
    sp = await SharedPreferences.getInstance();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        isUserLogin = sp.setBool('login', true);
        log('spInAtHomeCon-----${sp.getBool('login')}');
        log('spInAtHomeController-----${user.uid}');
      } else {
        log("spInAtHomeController----logout");
      }
    });
  }

  ///retrieve data from cloud fireStore
  Stream<List<NotesModel>> getNoteData() {
    return FirebaseFirestore.instance
        .collection("Notes")
        .where('userId',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid.toString())
        .orderBy('time', descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((item) => NotesModel.fromMap(item)).toList(),
        );
  }

  ///Delete From Firebase
  Future<void> deleteRecords() async {
    FirebaseFirestore.instance
        .collection("Notes")
        .doc(selectedItems.toString())
        .delete()
        .then((value) {
      log("message---$selectedItems");
      getSnackBar("Record Delete", "Record has been deleted successfully",
          Colors.red.shade500, 2);
    });
  }

  ///Delete Multiple Records From Firebase
  Future<void> batchDelete() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (String id in selectedItems) {
      DocumentReference ref =
          FirebaseFirestore.instance.collection("Notes").doc(id);
      batch.delete(ref);
    }

    batch.commit();
  }

  ///LogOut
  Future<User?> logOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      logOutLoading.value = true;
      await auth.signOut();
      Get.offAllNamed(Routes.login);
    } on FirebaseAuthException catch (e) {
      log("----SignOut------${e.toString()}");
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);
    } catch (e) {
      getSnackBar(
          "Some error accrues", "Please try again", Colors.red.shade500, 3);

      log("LogOut---->${e.toString()}");
    } finally {
      logOutLoading.value = false;
    }
    return user;
  }
}
