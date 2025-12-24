import 'package:flutter/material.dart';
import 'package:delivery_app/components/VerificationBox.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/profile.dart';

class VerificationScreen extends StatefulWidget {
  final Profile profile;

  const VerificationScreen({super.key, required this.profile});

  @override
  _VerificationScreenState createState() =>
      _VerificationScreenState(profile: profile);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final Profile profile;

  _VerificationScreenState({required this.profile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50), // إضافة مساحة علوية
              IconButton(
                icon: Icon(Icons.arrow_back, size: 35, color: darkBlack),
                onPressed: () =>
                    Navigator.pop(context), // العودة للشاشة السابقة
              ),
              SizedBox(height: 150), // إضافة مساحة قبل النص
              Center(
                child: Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  'Please type the verification code sent to:',
                  style: UiHelper.TextStyleGeneral,
                ),
              ),
              SizedBox(height: 2),
              Center(
                child: Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 15,
                    color: yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 70),
              Center(
                child: Container(
                  width: 380,
                  height: 65,
                  child: VerificationBox(profile: profile),
                ),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I don’t receive a code!  ',
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    child: Text(
                      'Resend It',
                      style: TextStyle(fontSize: 15, color: yellow),
                    ),
                    onTap: () {
                      // منطق إعادة الإرسال هنا
                      print("Resend code logic here");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
