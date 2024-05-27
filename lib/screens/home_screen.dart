import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_bloc.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_state.dart';
import 'package:zarity_health_assignment/cubits/blogs_cubit/blogs_cubit.dart';
import 'package:zarity_health_assignment/cubits/blogs_cubit/blogs_state.dart';
import 'package:zarity_health_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:zarity_health_assignment/cubits/user_cubit/user_state.dart';
import 'package:zarity_health_assignment/cubits/workout_cubit/workout_cubit.dart';
import 'package:zarity_health_assignment/cubits/workout_cubit/workout_state.dart';
import 'package:zarity_health_assignment/data/task.dart';
import 'package:zarity_health_assignment/routes/route_constants.dart';
import 'package:zarity_health_assignment/widgets/activity_tile.dart';
import 'package:zarity_health_assignment/widgets/blog_slider.dart';
import 'package:zarity_health_assignment/widgets/task_list.dart';
import 'package:zarity_health_assignment/widgets/workout_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final userState = context.watch<UserCubit>().state;
            final taskState = context.watch<TaskBloc>().state;
            final workoutState = context.watch<WorkoutCubit>().state;
            final blogsState = context.watch<BlogsCubit>().state;

            if (userState is UserLoadedState && taskState is TaskLoadedState) {
              User user = userState.user!;
              List<Task> tasks = taskState.tasks;

              String firstName = user.displayName!.substring(
                0,
                user.displayName!.indexOf(' '),
              );

              int progress = 0;

              for (Task task in tasks) {
                if (task.completed!) {
                  ++progress;
                }
              }

              return SizedBox.expand(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 25.0, right: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Hello $firstName 👋",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 21.sp,
                                        ),
                                  ),
                                  Gap(5.h),
                                  Text(
                                    "Good morning :)",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => context
                                    .pushNamed(RouteConstants.settingsScreen),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    height: 55.w,
                                    width: 55.w,
                                    fadeInCurve: Curves.easeIn,
                                    imageUrl: user.photoURL!,
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        "assets/placeholders/human.jpg",
                                      );
                                    },
                                    placeholder: (context, url) {
                                      return Image.memory(kTransparentImage);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(18.h),
                        InkWell(
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
                                    radius: 38.0,
                                    lineWidth: 9.0,
                                    percent: progress / tasks.length,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    animationDuration: 1,
                                    linearGradient: const LinearGradient(
                                      colors: [
                                        Color(0xff0082FD),
                                        Color(0xff0059B3),
                                      ],
                                    ),
                                    center: Text(
                                      "${((progress / tasks.length) * 100).toInt()}%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    // progressColor:
                                    //     Theme.of(context).primaryColor,
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                  Gap(14.w),
                                  Expanded(
                                    child: Text(
                                      progress == tasks.length
                                          ? "Great job! You've completed all your tasks for today!"
                                          : "Don't forget to complete your daily task.",
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
                        ),
                        Gap(26.h),
                        Text(
                          "Weekly stats",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800,
                                  ),
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const ActivityTile(
                              title: 'Steps',
                              iconPath: 'assets/icons/running.png',
                              progress: '9560 steps',
                            ),
                            Gap(5.w),
                            const ActivityTile(
                              title: 'Workout',
                              iconPath: 'assets/icons/workout.png',
                              progress: '2:45 hours',
                            ),
                            Gap(5.w),
                            const ActivityTile(
                              title: 'Heart Rate',
                              iconPath: 'assets/icons/heart.png',
                              progress: '102 BPM',
                            )
                          ],
                        ),
                        if (workoutState is WorkoutLoadedState)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Gap(26.h),
                              Text(
                                "Popular workouts",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                              ),
                              Gap(10.h),
                              WorkoutSlider(workouts: workoutState.workouts!),
                            ],
                          ),
                        if (blogsState is BlogsLoadedState)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Gap(26.h),
                              Text(
                                "Popular blogs",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                              ),
                              Gap(10.h),
                              BlogSlider(
                                blogs: blogsState.blogs,
                              ),
                            ],
                          ),
                        Gap(20.h),
                      ],
                    ),
                  ),
                ),
              );
            } else if (userState is UserErrorState ||
                taskState is TaskErrorState) {
              return const Center(child: Text("error"));
            }
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
