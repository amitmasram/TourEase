import 'package:TourEase/core/constants/text_strings.dart';
import 'package:TourEase/core/utils/responsive.dart';
import 'package:TourEase/core/utils/text_styles.dart';
import 'package:TourEase/view/widgets/custom_button.dart';
import 'package:TourEase/view/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/colors.dart';
import '../../../core/helpers/helper.dart';
import '../../../view-model/services/firebase/auth_service.dart';
import '../../../view-model/user_prefrences.dart';
import '../../main_screen/main_screen.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dark ? AppColors.dark : AppColors.light,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: dark ? AppColors.white : AppColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: Responsive.screenHeight(context) * 0.04),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: <Widget>[
                        Text(AppStrings.signUp, style: AppTextStyles.headline1),
                        const SizedBox(height: 20),
                        Text(
                          AppStrings.signupTitle,
                          style: AppTextStyles.onBoardingSubTitle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        SlideTransition(
                            position: _slideAnimation,
                            child: CustomTextField(
                              label: "Name",
                              controller: _nameController,
                              hintText: "Enter your name",
                              obscureText: false,
                            )),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.04),
                        SlideTransition(
                            position: _slideAnimation,
                            child: CustomTextField(
                              label: "Email",
                              controller: _emailController,
                              hintText: "Enter your email",
                              obscureText: false,
                            )),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.04),
                        SlideTransition(
                            position: _slideAnimation,
                            child: CustomTextField(
                            label: "Password",
                            controller: _passwordController,
                            obscureText: _obscureText,
                            hintText: 'Enter your password',
                            icon: _obscureText ? Icons.visibility_off : Icons.visibility,
                            onIconPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.05),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: GradientButton(
                            text: AppStrings.signUp,
                            width: Responsive.screenWidth(context) * 0.8,
                            onPressed: _signUp)),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.05),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already have an account?",
                            style: AppTextStyles.bodyText,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(AppStrings.signIn,
                                style: AppTextStyles.buttonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    String username = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      // Display an error message if email, password, or username is empty
      print("Name, email, and password are required.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Name, email, and password are required.")),
      );
      return;
    }

   try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        String userId = user.uid;

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'name': username,
          'email': email,
        });
        print("User is successfully created");

        await UserPreferences.setLoggedIn(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Failed to sign up user: $e");
      String message;
      switch (e.code) {
        case 'network-request-failed':
          message =
              "Network error occurred. Please check your internet connection.";
          break;
        case 'email-already-in-use':
          message = "The email address is already in use by another account.";
          break;
        case 'weak-password':
          message = "The password provided is too weak.";
          break;
        case 'invalid-email':
          message = "The email address is not valid.";
          break;
        default:
          message = "An unknown error occurred.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("Failed to sign up user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign up user: ${e.toString()}")),
      );
    }
  }
}
