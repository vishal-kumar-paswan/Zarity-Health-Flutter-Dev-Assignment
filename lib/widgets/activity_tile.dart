import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.progress,
  });

  final String title;
  final String iconPath;
  final String progress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    "assets/animations/celebration.json",
                    width: 165.w,
                    animate: true,
                    repeat: false,
                  ),
                  Text(
                    "Well done!\nKeep up the great work and continue your journey to better health!",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          },
        );
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        shadowColor: Colors.grey.shade500,
        child: Container(
          height: 132.h,
          width: (size.width / 3.8).w,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 13.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 0.1,
              color: Colors.black87,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gap(6.h),
              Image.asset(
                iconPath,
                width: 41.w,
              ),
              Gap(8.h),
              Text(
                progress,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 15.sp,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
