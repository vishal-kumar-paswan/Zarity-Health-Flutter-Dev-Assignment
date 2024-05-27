import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:zarity_health_assignment/routes/route_constants.dart';
import 'package:zarity_health_assignment/services/authentication/authentication_services.dart';
import 'package:zarity_health_assignment/utils/display_message.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void _displayMessage() {
    DisplayMessage.showToast("This feature will be added soon.", 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              ListTile(
                onTap: _displayMessage,
                leading: Icon(
                  Icons.person_rounded,
                  size: 22.sp,
                ),
                title: Text(
                  "Edit Profile",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 19.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.sp,
                ),
              ),
              ListTile(
                onTap: _displayMessage,
                leading: Icon(
                  Icons.privacy_tip,
                  size: 21.sp,
                ),
                title: Text(
                  "Privacy Policy",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 19.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.sp,
                ),
              ),
              ListTile(
                onTap: _displayMessage,
                leading: Icon(
                  Icons.info,
                  size: 22.sp,
                ),
                title: Text(
                  "About",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 19.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.sp,
                ),
              ),
              ListTile(
                onTap: () {
                  AuthenticationServices().signOutFromGoogle();
                  context.goNamed(RouteConstants.authenticationScreen);
                  DisplayMessage.showToast("Signed out successfully", 3);
                },
                leading: Icon(
                  Icons.logout_rounded,
                  size: 22.sp,
                ),
                title: Text(
                  "Sign out",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 19.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.sp,
                ),
              ),
              const Spacer(),
              Text(
                "Zarity®",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 23.sp,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const Text('Version 0.0.1'),
              Gap(15.h),
            ],
          ),
        ),
      ),
    );
  }
}
