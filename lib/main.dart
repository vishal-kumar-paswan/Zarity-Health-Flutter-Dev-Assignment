import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zarity_health_assignment/blocs/task_bloc/task_bloc.dart';
import 'package:zarity_health_assignment/cubits/blogs_cubit/blogs_cubit.dart';
import 'package:zarity_health_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:zarity_health_assignment/cubits/workout_cubit/workout_cubit.dart';
import 'package:zarity_health_assignment/routes/route_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(
              create: (BuildContext context) => UserCubit(),
            ),
            BlocProvider<TaskBloc>(
              create: (BuildContext context) => TaskBloc(),
            ),
            BlocProvider<WorkoutCubit>(
              create: (BuildContext context) => WorkoutCubit(),
            ),
            BlocProvider<BlogsCubit>(
              create: (BuildContext context) => BlogsCubit(),
            ),
          ],
          child: MaterialApp.router(
            builder: FToastBuilder(),
            routerConfig: RouteConfig.router,
            theme: ThemeData(
              primaryColor: const Color(0xff007DF3),
              textTheme: TextTheme(
                displayLarge: GoogleFonts.outfit(),
                titleLarge: GoogleFonts.outfit(),
                titleMedium: GoogleFonts.outfit(),
                bodyLarge: GoogleFonts.outfit(),
                bodyMedium: GoogleFonts.outfit(),
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
