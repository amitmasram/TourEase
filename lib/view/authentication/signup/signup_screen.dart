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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                              hintText: "Enter your password",
                              obscureText: true,
                              icon: Icons.visibility_off,
                            )),
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

  Widget makeInput({label, controller, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _signUp() async {
    String username = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Display an error message if email or password is empty
      print("Email and password are required.");
      // You can also show an error message to the user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email and password are required.")),
      );
      return;
    }

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      String userId = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': username,
        'email': email,
        // You can add more user data here
      });
      print("User is successfully created");

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
        SnackBar(content: Text("Failed to sign up user.")),
      );
    }
  }
}
