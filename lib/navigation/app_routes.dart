import 'package:flutter/material.dart';

PageRouteBuilder<T> slideUpRoute<T>(Widget page) => PageRouteBuilder<T>(
  pageBuilder: (_, __, ___) => page,
  transitionDuration: const Duration(milliseconds: 380),
  reverseTransitionDuration: const Duration(milliseconds: 300),
  transitionsBuilder: (_, anim, __, child) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(anim),
    child: child,
  ),
);

PageRouteBuilder<T> slideRightRoute<T>(Widget page) => PageRouteBuilder<T>(
  pageBuilder: (_, __, ___) => page,
  transitionDuration: const Duration(milliseconds: 350),
  reverseTransitionDuration: const Duration(milliseconds: 280),
  transitionsBuilder: (_, anim, secondaryAnim, child) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(anim),
    child: SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: const Offset(-0.25, 0))
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(secondaryAnim),
      child: child,
    ),
  ),
);
