import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/CustomDatePickerField.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/CustomPhoneTextField.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/logic/ProfileLogic.dart';

import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/MapScreen.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile profile;
  final String access_token;

  EditProfileScreen({required this.profile, required this.access_token});

  @override
  _EditProfileScreenState createState() =>
      _EditProfileScreenState(profile: profile, access_token: access_token);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Profile profile;
  final String access_token;
  _EditProfileScreenState({required this.profile, required this.access_token});
  final ProfileLogic _profileLogic = ProfileLogic();

  @override
  @override
  void dispose() {
    _profileLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Align(alignment: Alignment.topLeft, child: Backbotton()),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await _profileLogic.pickImage(context, () {
                      setState(() {}); // إعادة بناء الواجهة بعد اختيار الصورة
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 252, 193, 104),
                    radius: 100,
                    backgroundImage: _profileLogic.profileImage != null
                        ? FileImage(_profileLogic.profileImage!)
                        : null,
                    child: _profileLogic.profileImage == null
                        ? const Icon(
                            Icons.account_circle,
                            color: Colors.black,
                            size: 200,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              UiHelper.buildSectionTitle('UserName'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomNameTextField(
                      controller: _profileLogic.firstNameController,
                      fieldName: 'First Name',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomNameTextField(
                      controller: _profileLogic.lastNameController,
                      fieldName: 'Last Name',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              UiHelper.buildSectionTitle('Phone Number'),
              const SizedBox(height: 10),
              CustomPhoneTextField(controller: _profileLogic.phoneController),
              const SizedBox(height: 20),
              UiHelper.buildSectionTitle('Birth-Date'),
              const SizedBox(height: 10),
              CustomDatePickerField(
                controller: _profileLogic.birthDateController,
                fieldName: 'Birth Date',
                datePickerLogic: _profileLogic.datePickerLogic,
              ),
              const SizedBox(height: 30),
              Center(
                child: CustomButton(
                  textOfButton: 'Next',
                  onPressed: () async {
                    profile.firstName = _profileLogic.firstNameController.text;
                    profile.lastName = _profileLogic.lastNameController.text;
                    profile.phoneNumber = _profileLogic.phoneController.text;
                    profile.dateOfBirth =
                        _profileLogic.birthDateController.text;
                    profile.profileImage = _profileLogic.profileImage
                        .toString();

                    // التأكيد والانتقال
                    _profileLogic.handleConfirm(
                      access_token: access_token,
                      context,
                      profile: profile,
                      onSuccess: (profile) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            profile: profile,
                            access_token: access_token,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
