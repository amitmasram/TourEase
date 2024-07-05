import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/main_screen/main_screen.dart';
import '../view/onboarding/onboarding_screen.dart';
import 'app_theme.dart';

class TourEase extends StatefulWidget {
  // ignore: use_super_parameters
  const TourEase({Key? key}) : super(key: key);

  @override
  State<TourEase> createState() => _TourEaseState();
}

class _TourEaseState extends State<TourEase> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkIfUserLoggedIn();
  }

  void _checkIfUserLoggedIn() {
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
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
        routes: {},
        home: _user != null ? const MainScreen() : const OnboardingScreen(),
      );
    }
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
