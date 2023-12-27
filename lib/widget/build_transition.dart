import 'package:flutter/material.dart';

class Fade<T> extends PageRouteBuilder<T> {
  final Widget page;

  Fade({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return FadeTransition(
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: page,
            );
          },
        );
}

class Rotation<T> extends PageRouteBuilder<T> {
  final Widget page;

  Rotation({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return RotationTransition(
              alignment: Alignment.center,
              turns:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
              child: page,
            );
          },
        );
}

class SlideHorizontal<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideHorizontal({required this.page, required super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
              Widget page) {
            final CurvedAnimation curvedAnimation =
                CurvedAnimation(parent: animation1, curve: Curves.ease);
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(curvedAnimation),
              child: page,
            );
          },
        );
}

class ScaleRotateRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRotateRoute({required this.page, required super.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
              ),
              child: child,
            ),
          ),
        );
}
