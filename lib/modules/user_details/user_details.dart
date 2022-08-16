import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:sizer/sizer.dart';

class UserDetails extends StatelessWidget {
  UserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.buttonColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              FirebaseAuth.instance.currentUser!.displayName.toString(),
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.emailVerified.toString(),
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.uid.toString(),
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
