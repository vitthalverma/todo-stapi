import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.name, required this.onTap});
  final String name;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 8.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          color: Colors.deepPurple,
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                color: white, fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
