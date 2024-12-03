import 'package:TourEase/view/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view-model/user_prefrences.dart';
import '../view/main_screen/main_screen.dart';
import 'app_theme.dart';

class TourEase extends StatefulWidget {
  // ignore: use_super_parameters
  const TourEase({Key? key}) : super(key: key);

  @override
  State<TourEase> createState() => _TourEaseState();
}

class _TourEaseState extends State<TourEase> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await UserPreferences.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoading();
    } else {
      return MaterialApp(
        title: 'TourEase',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routes: const {},
        home: _isLoggedIn ? const MainScreen() : const OnboardingScreen(),
      );
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
