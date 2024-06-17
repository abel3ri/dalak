import 'package:dalak_blog_app/pages/ArticleDetailsPage.dart';
import 'package:dalak_blog_app/pages/CommentsPage.dart';
import 'package:dalak_blog_app/pages/NoConnectionPage.dart';
import 'package:dalak_blog_app/pages/OnBoardingPage.dart';
import 'package:dalak_blog_app/pages/SignupPage.dart';
import 'package:go_router/go_router.dart';

import 'package:dalak_blog_app/pages/HomePage.dart';
import 'package:dalak_blog_app/pages/LoginPage.dart';
import 'package:dalak_blog_app/pages/SplashPage.dart';
import 'package:dalak_blog_app/utils/SlideTransition.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: 'splashPage',
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: "/home",
        name: 'homePage',
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          rtl: false,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: "/signup",
        name: "signup",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          rtl: false,
          child: const SignupPage(),
        ),
      ),
      GoRoute(
        path: "/on-boarding",
        name: "onBoarding",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: const OnBoardingPage(),
        ),
      ),
      GoRoute(
        path: "/no-connection",
        name: "noConnection",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: const NoConnectionPage(),
        ),
      ),
      GoRoute(
        path: "/article-details",
        name: "articleDetails",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: const ArticlesDetailPage(),
        ),
      ),
      GoRoute(
        path: "/comments",
        name: "comments",
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          rtl: false,
          child: const CommentsPage(),
        ),
      ),
    ],
  );
}
