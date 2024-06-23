import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/main_screen/main_screen.dart';
import '../views/onboarding/onboarding.dart';

class VTG extends StatefulWidget {
  const VTG({Key? key}) : super(key: key);

  @override
  State<VTG> createState() => _VTGState();
}

class _VTGState extends State<VTG> {
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
        title: 'VTG App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        home: _user != null ? MainScreen() : Onboarding(),
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
