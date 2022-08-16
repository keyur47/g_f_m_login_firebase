import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onPressed;
  final bool change;

  const CustomButton({super.key, required this.child, required this.onPressed, this.change = false,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            gradient: change ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(243, 169, 95, 0.3),
                Color.fromRGBO(235, 101, 91, 0.3)
              ],
            ) : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(243, 169, 95, 1.0),
                Color.fromRGBO(235, 101, 91, 1.0)
              ],
            ),
          ),
          child: Center(child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.h),
            child: child,
          )),
        ),
      ),
    );
  }
}

Widget backButton() {
  return InkWell(
    onTap: () {
      // Navigation.popAndPushNamed(Routes.loginPage);
      Get.back();
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          const Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}



// ElevatedButton(
// onPressed: onPressed,
// style: ButtonStyle(
// padding: MaterialStateProperty.all(
// EdgeInsets.symmetric(vertical: 2.h),
// ),
// backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
// shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(18.0),
// ),
// ),
// ),
// child: child,
// );