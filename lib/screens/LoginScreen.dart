import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/PasswordTextField.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/HomeScreen.dart';
import 'package:delivery_app/screens/SignupScreen.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/service/getProfile.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  void _handleConfirm() async {
    if (emailController.text.isEmpty || passWordController.text.isEmpty) {
      UiHelper.showAlert(
        context: context,
        title: 'Error',
        content: 'Please fill in all the fields before proceeding.',
      );
      return;
    }

    http.Response response = await posts(
      url: 'http://10.0.2.2:8000/api/v1/user/login',
      body: {
        "email": emailController.text,
        "password": passWordController.text,
        "role": "user",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String access_token = data["access_token"];

      Profile profile = await fetchProfile(access_token);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(profile: profile, access_token: access_token),
        ),
      );
    } else {
      Map<String, dynamic> error = jsonDecode(response.body);

      if (error["message"] == "Invalid password") {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'Wrong Password.',
        );
        return;
      } else if (error["message"] == "Invalid email") {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'Wrong Email.',
        );
        return;
      } else {
        UiHelper.showAlert(
          context: context,
          title: 'Error',
          content: 'Enter A Valid Email or Password.',
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/delivery_apponlin.jpg',
            ), // مكان الصورة
            fit: BoxFit.cover, // لتغطية الشاشة
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiHelper.BigTitle('Log in'),
                  SizedBox(height: 24),
                  UiHelper.buildSectionTitle('Enter Your E-mail'),
                  SizedBox(height: 8),
                  CustomNameTextField(
                    controller: emailController,
                    fieldName: 'E-mail',
                  ),
                  SizedBox(height: 24),
                  UiHelper.buildSectionTitle('Enter Your Password'),
                  SizedBox(height: 8),
                  PasswordTextField(
                    controller: passWordController,
                    hintText: 'Enter your password',
                  ),
                  SizedBox(height: 55),
                  Center(
                    child: CustomButton(
                      textOfButton: 'Next',
                      onPressed: () => _handleConfirm(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UiHelper.TextGrey(' Dont have an account ?'),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          ),
                          child: UiHelper.BigTextYellow(' Sign up'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
