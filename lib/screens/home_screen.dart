import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_bloc.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_state.dart';
import 'package:zarity_health_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:zarity_health_assignment/cubits/user_cubit/user_state.dart';
import 'package:zarity_health_assignment/data/task.dart';
import 'package:zarity_health_assignment/routes/route_constants.dart';
import 'package:zarity_health_assignment/services/authentication/authentication_services.dart';
import 'package:zarity_health_assignment/utils/display_message.dart';
import 'package:zarity_health_assignment/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadedState) {
              User user = state.user!;

              return SizedBox.expand(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 16.0, right: 15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                height: 65.w,
                                width: 65.w,
                                fadeInCurve: Curves.easeIn,
                                imageUrl: user.photoURL!,
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    "assets/placeholders/human.jpg",
                                  );
                                },
                              ),
                            ),
                            Gap(8.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Hey there,",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(user.displayName!),
                              ],
                            ),
                            const Spacer(),
                            Icon(
                              Icons.mail,
                              color: Theme.of(context).primaryColor,
                              size: 20.sp,
                            ),
                            Gap(20.w),
                            InkWell(
                              onTap: () {
                                AuthenticationServices().signOutFromGoogle();
                                context.goNamed(
                                    RouteConstants.authenticationScreen);
                                DisplayMessage.showToast(
                                  "Signed out successfully!",
                                  3,
                                );
                              },
                              child: Icon(
                                Icons.notifications,
                                color: Theme.of(context).primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20.h),
                      BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, state) {
                          if (state is TaskLoadedState) {
                            List<Task> tasks = state.tasks;
                            int progress = 0;

                            for (Task task in tasks) {
                              if (task.completed!) {
                                progress++;
                              }
                            }

                            return InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return TaskList(tasks: tasks);
                                  },
                                );
                              },
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(15),
                                shadowColor: Colors.grey.shade500,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.w,
                                    vertical: 20.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      width: 0.1,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 40.0,
                                        lineWidth: 10.0,
                                        percent: progress / tasks.length,
                                        center: Text(
                                          "${(progress / tasks.length) * 100}%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.grey.shade800,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        progressColor:
                                            Theme.of(context).primaryColor,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                      Gap(14.w),
                                      Expanded(
                                        child: Text(
                                          progress == tasks.length
                                              ? "Great job! You've completed all your tasks for today!"
                                              : "Don't forget to complete your daily task. Every step counts towards a healthier you!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.grey.shade800,
                                                fontSize: 14.sp,
                                              ),
                                          softWrap: true,
                                        ),
                                      ),
                                      Gap(5.w),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey.shade600,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      Gap(50.h),
                    ],
                  ),
                ),
              );
            } else if (state is UserErrorState) {
              return const Center(child: Text("error"));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
