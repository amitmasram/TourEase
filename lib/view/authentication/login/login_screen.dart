import 'package:TourEase/core/constants/text_strings.dart';
import 'package:TourEase/core/utils/responsive.dart';
import 'package:TourEase/core/utils/text_styles.dart';
import 'package:TourEase/view/widgets/custom_button.dart';
import 'package:TourEase/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/colors.dart';
import '../../../core/helpers/helper.dart';
import '../../../view-model/services/firebase/auth_service.dart';
import '../../main_screen/main_screen.dart';
import '../forget_password_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        child: SizedBox(
          height: Responsive.screenHeight(context) * 0.9,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.04),
                        Text(
                          AppStrings.signIn,
                          style: AppTextStyles.headline1,
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.03),
                        Text(
                          AppStrings.loginSubTitle,
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
                            label: "Email",
                            controller: _emailController,
                            obscureText: false,
                            hintText: 'Enter your email',
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.04),
                        SlideTransition(
                          position: _slideAnimation,
                          child: CustomTextField(
                            label: "Password",
                            controller: _passwordController,
                            obscureText: true,
                            hintText: 'Enter your password',
                            icon: Icons.visibility_off,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.03),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: AppTextStyles.bodyText.copyWith(
                              color: AppColors.secondary,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.05),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: GradientButton(
                            text: AppStrings.signIn,
                            width: Responsive.screenWidth(context) * 0.8,
                            onPressed: _signIn)),
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
                            "Don't have an account?",
                            style: AppTextStyles.bodyText,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: Text(AppStrings.signUp,
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

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Display an error message if email or password is empty
      print("Email and password are required.");
      // You can also show an error message to the user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email and password are required.")),
      );
      return;
    }

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully Sign In");
      // Navigate to the MainScreen after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // Display an error message if signup fails
      print("Failed to sign up user.");
      // You can also show an error message to the user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to sign up user.")),
      );
    }
  }
}
