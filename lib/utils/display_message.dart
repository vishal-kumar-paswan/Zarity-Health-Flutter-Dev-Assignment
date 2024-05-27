import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zarity_health_assignment/utils/navigation_key.dart';

class DisplayMessage {
  static void showToast(String message, int duration) {
    final fToast = FToast();
    fToast.init(NavigationService.rootNavigatorKey.currentState!.context);
    Widget toast = Container(
      margin: EdgeInsets.only(bottom: 50.h),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade800,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.shade800,
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }
}
