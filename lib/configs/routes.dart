import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/auth_screen_binding.dart';
import '../bindings/story_screen_binding.dart';
import '../screens/auth.dart';
import '../screens/main/layout.dart';
import '../screens/splash.dart';
import '../screens/story.dart';

/// [AppRouter] instance that will be used in
/// the whole app.
const AppRouter router = AppRouter._();

/// Manage routing operations across the app
class AppRouter {
  const AppRouter._();

  /// return url format of a defined [Routes]
  String getRouteName(Routes route) => '/${route.name}';

  /// Pushes a new named page to the stack.
  void push(Routes route, {dynamic arguments}) =>
      Get.toNamed(getRouteName(route), arguments: arguments);

  /// Pop the current page and pushes a new page to the stack if [clearHistory] is false,
  /// Else Push a named page and pop several pages in the stack until [predicate] returns true.
  /// Check `GetX` documentation to know more about navigation. https://pub.dev/getx
  void replace(Routes route, {dynamic arguments, bool clearHistory = false}) {
    String routeName = getRouteName(route);

    clearHistory
        ? Get.offAllNamed(routeName, arguments: arguments)
        : Get.off(routeName, arguments: arguments);
  }

  /// Build pages from defined routes.
  List<GetPage> get pages => Routes.values
      .map((route) => GetPage(
          name: getRouteName(route),
          page: () => route.page,
          binding: route.binding,
          transition: route.transition))
      .toList();
}

/// App routes
enum Routes { splash, auth, main, story }

extension on Routes {
  /// return the widget attached to a route.
  Widget get page {
    switch (this) {
      case Routes.splash:
        return const SplashScreen();
      case Routes.auth:
        return const AuthScreen();
      case Routes.main:
        return const MainScreen();
      case Routes.story:
        return const StoryScreen();
    }
  }

  Bindings? get binding {
    switch (this) {
      case Routes.auth:
        return AuthScreenBinding();
      case Routes.story:
        return StoryScreenBinding();
      default:
        return null;
    }
  }

  /// Define the transition animation to apply
  /// when navigating to a page
  Transition? get transition {
    switch (this) {
      case Routes.story:
        return Transition.downToUp;
      default:
        return Transition.rightToLeft;
    }
  }
}
