import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task360/app/global/helper/extension/extension.dart';
import 'package:task360/app/view/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:task360/app/view/screens/home/details/details_screen.dart';
import 'package:task360/app/view/screens/home/home_screen.dart';
import 'package:task360/app/view/screens/splash/splash_screen.dart';
import '../view/screens/authentication/sign_in/sign_in_screen.dart';
import 'route_path.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
      initialLocation: RoutePath.splashScreen.addBasePath,
      debugLogDiagnostics: true,
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: [
        ///======================= Initial Route =======================
        GoRoute(
          name: RoutePath.splashScreen,
          path: RoutePath.splashScreen.addBasePath,
          pageBuilder: (context, state) => _buildPageWithAnimation(
            child: SplashScreen(),
            state: state,
          ),
        ),

        ///======================= Auth Route =======================
        GoRoute(
          name: RoutePath.signInScreen,
          path: RoutePath.signInScreen.addBasePath,
          pageBuilder: (context, state) => _buildPageWithAnimation(
            child: SignInScreen(),
            state: state,
          ),
        ),

        GoRoute(
          name: RoutePath.signUpScreen,
          path: RoutePath.signUpScreen.addBasePath,
          pageBuilder: (context, state) => _buildPageWithAnimation(
            child: SignUpScreen(),
            state: state,
          ),
        ),
        // GoRoute(
        //   name: RoutePath.authGate,
        //   path: RoutePath.authGate.addBasePath,
        //   pageBuilder: (context, state) => _buildPageWithAnimation(
        //     child: const AuthGate(),
        //     state: state,
        //   ),
        // ),

        ///======================= Home Route =======================

        GoRoute(
          name: RoutePath.homeScreen,
          path: RoutePath.homeScreen.addBasePath,
          pageBuilder: (context, state) => _buildPageWithAnimation(
            child:  HomeScreen(),
            state: state,
            disableAnimation: true
          ),
        ),
        GoRoute(
          name: RoutePath.detailsScreen,
          path: RoutePath.detailsScreen.addBasePath,
          pageBuilder: (context, state) => _buildPageWithAnimation(
            child: const DetailsScreen(),
            state: state,
          ),
        ),
      ]);

  static CustomTransitionPage _buildPageWithAnimation(
      {required Widget child,
      required GoRouterState state,
      bool disableAnimation = false}) {
    if (disableAnimation) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: Duration.zero, // Disable animation
        transitionsBuilder: (_, __, ___, child) => child, // No transition
      );
    } else {
      return CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
    }
  }

  static GoRouter get route => initRoute;
}
