import 'package:dalak/pages/NoConnectionPage.dart';
import 'package:dalak/pages/OnBoardingPage.dart';
import 'package:dalak/pages/SignupPage.dart';
import 'package:go_router/go_router.dart';

import 'package:dalak/pages/HomePage.dart';
import 'package:dalak/pages/LoginPage.dart';
import 'package:dalak/pages/SplashPage.dart';
import 'package:dalak/utils/SlideTransition.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: 'splashPage',
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: "/home",
        name: 'homePage',
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          rtl: false,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: "/signup",
        name: "signup",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          rtl: false,
          child: SignupPage(),
        ),
      ),
      GoRoute(
        path: "/on-boarding",
        name: "onBoarding",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: OnBoardingPage(),
        ),
      ),
      GoRoute(
        path: "/no-connection",
        name: "noConnection",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: NoConnectionPage(),
        ),
      ),
    ],
  );
}
