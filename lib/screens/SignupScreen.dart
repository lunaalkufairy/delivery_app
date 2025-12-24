import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/PasswordTextField.dart';
import 'package:delivery_app/components/PrivacyChecker.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/LoginScreen.dart';
import 'package:delivery_app/screens/VerificationScreen.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isPrivacyChecked = false; // حالة الموافقة على الخصوصية

  void _handleConfirm() async {
    if (emailController.text.isEmpty ||
        passWordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      UiHelper.showAlert(
        context: context,
        title: 'Error',
        content: 'Please fill in all the fields before proceeding.',
      );
      return;
    }

    if (!_isPrivacyChecked) {
      UiHelper.showAlert(
        context: context,
        title: 'Error',
        content: 'You must agree to the Terms of Service and Privacy Policy.',
      );
      return;
    }

    http.Response response = await posts(
      url: 'http://10.0.2.2:8000/api/v1/user/register',
      body: {
        "email": emailController.text,
        "password": passWordController.text,
        "password_confirmation": confirmPasswordController.text,
        "role": "user",
      },
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Profile profile = Profile(
        firstName: 'q',
        lastName: 'q',
        email: emailController.text,
        phoneNumber: 'q',
        dateOfBirth: 'q',
        profileImage: 'q',
        address: 'q',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(profile: profile),
        ),
      );
    } else {
      Map<String, dynamic> error = jsonDecode(response.body);

      if (error["message"] ==
              "The email field must be a valid email address." ||
          error["message"] ==
              "The email field must be a valid email address. (and 1 more error)") {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'Please Enter a valid email address.',
        );
        return;
      }
      if (error["message"] ==
          "The password field confirmation does not match.") {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'Passwords do not match. Please try again.',
        );
        return;
      }
      if (error["message"] == "The email address is already registered.") {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'The email address is already registered.',
        );
        return;
      } else {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'Enter a valid input',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/delivery_apponlinsignup.jpg', // استبدل بالمسار الصحيح للصورة
              fit: BoxFit.cover,
            ),
          ),
          // باقي المكونات
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Align(alignment: Alignment.topLeft, child: Backbotton()),
                    SizedBox(height: 20),
                    UiHelper.MainTitle('Sign up'),
                    const SizedBox(height: 20),
                    UiHelper.buildSectionTitle('Enter Your E-mail'),
                    const SizedBox(height: 8),
                    CustomNameTextField(
                      controller: emailController,
                      fieldName: 'E-mail',
                    ),
                    const SizedBox(height: 20),
                    UiHelper.buildSectionTitle('Enter Your Password'),
                    const SizedBox(height: 8),
                    PasswordTextField(
                      controller: passWordController,
                      hintText: 'Enter your password',
                    ),
                    const SizedBox(height: 20),
                    UiHelper.buildSectionTitle('Confirm Your Password'),
                    const SizedBox(height: 8),
                    PasswordTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm your password',
                    ),
                    const SizedBox(height: 20),
                    PrivacyChecker(
                      onChecked: (isChecked) {
                        setState(() {
                          _isPrivacyChecked = isChecked;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: CustomButton(
                        textOfButton: 'Verify your number',
                        onPressed: _handleConfirm,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UiHelper.TextGrey(' Do have an account ? '),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            ),
                            child: UiHelper.TextYellow('Log in'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
