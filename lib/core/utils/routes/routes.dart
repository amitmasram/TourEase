import 'package:TourEase/view/authentication/home_auth_screen.dart';
import 'package:TourEase/view/authentication/signup/signup_screen.dart';
import 'package:TourEase/view/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../../view/authentication/login/login_screen.dart';
import '../../../view/main_screen/home/home_screen.dart';

import 'routes_name.dart';

/// A class that handles generating routes for the app.
///
/// This class uses the MaterialPageRoute to generate routes for the app.
/// It checks the name of the route and returns the corresponding screen.
/// If no route is defined, it returns a default screen with a message.
class Routes {
  /// Generates a route based on the given RouteSettings.
  ///.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final arguments = settings.arguments;

    // Check the name of the route
    switch (settings.name) {
      // If the route is for the splash screen, return a MaterialPageRoute with the SplashScreen as the builder
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case RoutesName.homeAuth:
        return MaterialPageRoute(builder: (context) => const HomeAuthScreen());

      // If no route is defined, return a MaterialPageRoute with a default screen
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
