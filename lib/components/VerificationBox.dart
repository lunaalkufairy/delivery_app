import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/AddProfileScreen.dart';
import 'package:http/http.dart' as http;

class VerificationBox extends StatefulWidget {
  // البريد الإلكتروني المُدخل
  final Profile profile; // كلمة المرور المُدخلة
  const VerificationBox({super.key, required this.profile});

  @override
  State<VerificationBox> createState() =>
      _VerificationBoxState(profile: profile);
}

class _VerificationBoxState extends State<VerificationBox> {
  final Profile profile;

  _VerificationBoxState({required this.profile});
  Color focusedColor = yellow;
  Color borderColor = greydark;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      focusedPinTheme: PinTheme(
        textStyle: TextStyle(color: focusedColor),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border.all(color: focusedColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      defaultPinTheme: PinTheme(
        textStyle: TextStyle(color: focusedColor, fontSize: 30),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      length: 6,
      submittedPinTheme: PinTheme(
        textStyle: TextStyle(color: focusedColor, fontSize: 30),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border.all(color: focusedColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      //=================================================================
      //========================= validation ============================
      //=================================================================
      onSubmitted: (value) {
        if (value.length != 6) {
          setState(() {
            focusedColor = red;
            borderColor = red;
            UiHelper.showAlert(
              context: context,
              title: 'ERROR',
              content: 'Please enter a valid number',
            );
          });
        }
      },
      onChanged: (value) {
        setState(() {
          focusedColor = yellow;
          borderColor = greydark;
        });
      },
      onCompleted: (value) async {
        print('QQQQQQQQQQQQQQQQ855555555555555');

        http.Response response = await posts(
          url: 'http://10.0.2.2:8000/api/v1/user/verify-email',
          body: {
            "email": profile.email,
            "verification_code": value,
            "role": "user",
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          print(data);
          String access_token = data["access_token"];
          // إنشاء الكائن UserProfile

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return EditProfileScreen(
                  profile: profile,
                  access_token: access_token,
                );
              },
            ),
          );
        } else {
          Map<String, dynamic> error = jsonDecode(response.body);
          print((error["message"]));

          if (error["message"] == "Invalid verification code.") {
            setState(() {
              focusedColor = red;
            });
            UiHelper.showAlert(
              context: context,
              title: 'Error',
              content: 'Invalid verification code.',
            );
          }
        }
        // إنشاء الكائن UserProfile
        // UserProfile userProfile = UserProfile(
        //   firstName: '',
        //   lastName: '',
        //   phoneNumber: '',
        //   birthDate: '',
        //   email: widget.email,
        //   password: widget.password,
        //   profileImage: null,
        // );

        // // الانتقال إلى شاشة EditProfileScreen مع تمرير الكائن
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => EditProfileScreen(userProfile: userProfile),
        //   ),
        // );
        //  else {
        //   print('=========ERROR=========');
        //   setState(() {
        //     focusedColor = red;
        //     UiHelper.showAlert(
        //       context: context,
        //       title: 'WRONG NUMBER',
        //       content: 'Please enter a valid number',
        //     );
        //   });
        // }
      },
    );
  }
}
