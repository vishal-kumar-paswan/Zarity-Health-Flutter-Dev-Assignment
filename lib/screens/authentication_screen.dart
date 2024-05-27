import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:zarity_health_assignment/routes/route_constants.dart';
import 'package:zarity_health_assignment/services/authentication/authentication_services.dart';
import 'package:zarity_health_assignment/utils/display_message.dart';
import 'package:zarity_health_assignment/utils/log_message.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              Text(
                "Zarity®",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              Gap(8.h),
              Text(
                "Your personal companion for a healthier, happier you!",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 13.sp),
              ),
              Gap(30.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    double.infinity,
                    52.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      width: 0.1,
                      color: Colors.black87,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.6,
                  shadowColor: Colors.black,
                ),
                onPressed: () async {
                  final authenticationServices = AuthenticationServices();
                  UserCredential userCredential =
                      await authenticationServices.signInWithGoogle();

                  final user = userCredential.user;

                  if (user != null) {
                    String firstName = user.displayName!.substring(
                      0,
                      user.displayName!.indexOf(' '),
                    );

                    if (context.mounted) {
                      context.goNamed(RouteConstants.homeScreen);
                    }
                    LogMessage(user.email!);

                    bool userExists =
                        await authenticationServices.checkUserExists(user.uid);

                    if (userExists) {
                      DisplayMessage.showToast(
                        "Welcome back, $firstName",
                        3,
                      );
                    } else {
                      authenticationServices.storeUserData(
                        user.uid,
                        user.email!,
                        user.displayName!,
                      );
                      DisplayMessage.showToast(
                        "Welcome onboard, $firstName",
                        3,
                      );
                    }
                  } else {
                    DisplayMessage.showToast(
                      "Failed to login, please try again!",
                      3,
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/google.png",
                      height: 32,
                      width: 32,
                    ),
                    Gap(15.w),
                    Text(
                      'Continue with Google',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 16.sp,
                          ),
                    ),
                  ],
                ),
              ),
              // TODO: Add Facebook login
              // Gap(16.h),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     fixedSize: Size(
              //       double.infinity,
              //       52.h,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       side: const BorderSide(
              //         width: 0.1,
              //         color: Colors.black87,
              //       ),
              //     ),
              //     backgroundColor: Colors.blue.shade500,
              //     elevation: 0.5,
              //     shadowColor: Colors.black,
              //   ),
              //   onPressed: () {},
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         "assets/icons/facebook.png",
              //         height: 32,
              //         width: 32,
              //       ),
              //       Gap(15.w),
              //       Text(
              //         'Continue with Facebook',
              //         style: Theme.of(context)
              //             .textTheme
              //             .bodyLarge!
              //             .copyWith(fontSize: 16.sp, color: Colors.white),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
