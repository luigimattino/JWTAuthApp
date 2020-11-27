import 'screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/register/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const HomeRoute = '/';
  static const RegisterRoute = '/register';
  static const LoginRoute = '/login';
  static const ResourcesRoute = '/resources';

  static final RouteFactory routes = (settings) {
    final Map<String, dynamic> arguments = settings.arguments;

    Widget screen;
    switch (settings.name) {
      case LoginRoute:
        screen = LoginScreen();
        break;
      case RegisterRoute:
        screen = RegisterScreen();
        break;
      case HomeRoute:
        screen = HomeScreen();
        break;
      default:
        return null;
    }
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
    );
  };
}
