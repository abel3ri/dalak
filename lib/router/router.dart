import 'package:dalak/pages/HomePage.dart';
import 'package:dalak/pages/SplashPage.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: 'homePage',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: "/splash",
        name: 'splashPage',
        builder: (context, state) => SplashPage(),
      )
    ],
  );
}
