import 'package:flutter/material.dart';
import 'package:g_f_m_login_firebase/utils/app_color.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  String titleText;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  String hintText;
  TextEditingController textEditingController;
  bool? obscure;
  bool? focus;
  FormFieldValidator<String>? validator;
  Widget? suffixIcon;
  AutovalidateMode? autoValidateMode;
  ValueChanged<String>? onChanged;
  CustomTextField(
      {super.key,
      required this.titleText,
      required this.keyboardType,
      required this.textInputAction,
      required this.hintText,
      this.obscure,
      required this.textEditingController,
      this.validator,
      this.focus,
      this.suffixIcon,
      this.autoValidateMode,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(fontSize: 15.sp),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.5.h),
          child: TextFormField(
            autovalidateMode: autoValidateMode,
            controller: textEditingController,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscure ?? false,
            onChanged: onChanged,
            autofocus: focus ?? false,
            cursorColor: AppColors.black,

            // maxLines: maxLines ?? 0,
            style: TextStyle(fontSize: 12.sp),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(),
              focusColor: AppColors.black,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 12.sp),
              // suffix: GestureDetector(),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
