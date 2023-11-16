import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

BuildContext? get globalContext {
  return Go.navigatorKey.currentContext;
}

class Go {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static get currentContext {
    return navigatorKey.currentContext;
  }

  static to(Widget page) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static toTransition(
    Widget page,
  ) async {
    await navigatorKey.currentState
        ?.push(PageTransition(child: page, type: PageTransitionType.fade));
  }

  static back() {
    // navigatorKey.currentState!.pop(currentContext);
    Navigator.pop(globalContext!);
  }

  static close() {
    // navigatorKey.currentState!.pop(currentContext);
    Navigator.of(globalContext!).pop(true);
  }

  static offAll(page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  static double get width {
    return MediaQuery.of(currentContext).size.width;
  }

  static double get height {
    return MediaQuery.of(currentContext).size.width;
  }
}
