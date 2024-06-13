import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideTransitionPage extends CustomTransitionPage {
  SlideTransitionPage({
    required LocalKey key,
    required Widget child,
    bool rtl = true,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: rtl ? const Offset(1, 0) : const Offset(0, 1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: duration,
        );
}
