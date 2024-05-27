import 'package:go_router/go_router.dart';
import 'package:zarity_health_assignment/routes/route_constants.dart';
import 'package:zarity_health_assignment/screens/authentication_screen.dart';
import 'package:zarity_health_assignment/screens/home_screen.dart';
import 'package:zarity_health_assignment/screens/splash_screen.dart';
import 'package:zarity_health_assignment/utils/navigation_key.dart';

class RouteConfig {
  static GoRouter router = GoRouter(
    navigatorKey: NavigationService.rootNavigatorKey,
    initialLocation: '/splash-screen',
    routes: [
      GoRoute(
        name: RouteConstants.splashScreen,
        path: '/splash-screen',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteConstants.authenticationScreen,
        path: '/authentication-screen',
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        name: RouteConstants.homeScreen,
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
