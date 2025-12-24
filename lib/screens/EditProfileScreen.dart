import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/CustomDatePickerField.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/CustomPhoneTextField.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/logic/DatePickerLogic.dart';
import 'package:delivery_app/logic/ProfileLogic.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/screens/EditLcationScreen.dart';

class EditprofileScreen extends StatefulWidget {
  final Profile profile;
  final String access_token;
  EditprofileScreen({required this.profile, required this.access_token});

  @override
  State<EditprofileScreen> createState() =>
      _EditprofileScreenState(profile: profile, access_token: access_token);
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final Profile profile;
  final String access_token;
  _EditprofileScreenState({required this.profile, required this.access_token});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // بعض الكائنات للمنطق (للتحكم في طريقة المعالجة)
  final DatePickerLogic _datePickerLogic = DatePickerLogic();
  final ProfileLogic _profileLogic = ProfileLogic();
  final _key = GlobalKey<FormState>();

  void _handleConfirm() async {
    if (phoneController.text.isEmpty &&
        firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty &&
        birthDateController.text.isEmpty) {
      UiHelper.showAlert(
        context: context,
        title: 'Error',
        content: 'No information to update',
      );
      return;
    }

    print(phoneController.text);
    if (phoneController.text.isEmpty ||
        phoneController.text == profile.phoneNumber) {
      print(profile.firstName);
      print(profile.lastName);
      print(profile.dateOfBirth);
      print(profile.address);

      if (firstNameController.text.isNotEmpty) {
        profile.firstName = firstNameController.text;
        print('11111111');
      }
      if (lastNameController.text.isNotEmpty) {
        profile.lastName = lastNameController.text;
        print('2222222');
      }
      if (birthDateController.text.isNotEmpty) {
        profile.dateOfBirth = birthDateController.text;
        print('3333333');
      }

      print(profile.firstName);
      print(profile.lastName);
      print(profile.dateOfBirth);
      print(profile.address);

      http.Response response = await posts(
        url: 'http://10.0.2.2:8000/api/v1/user/complete-profile',
        body: {
          'first_name': profile.firstName,
          'last_name': profile.lastName,
          'date_of_birth': profile.dateOfBirth,
          'address': profile.address,
          'city': 'aa',
        },
        token: access_token,
      );

      if (response.statusCode != 200) {
        Map<String, dynamic> error = jsonDecode(response.body);
        print('qqqqqqqqqq5555555');
        print(error);

        if (error["message"] ==
            "The date of birth field must be a date before today.") {
          UiHelper.showAlert(
            context: context,
            title: 'ERROR',
            content: "The date of birth field must be a date before today.",
          );
          return;
        }

        return;
      }

      Navigator.pop(context);
      UiHelper.showAlert(
        context: context,
        title: 'Success',
        content: 'Yor inforation has been updated',
      );

      //========================================================================
      //=============== IF THE ARE A PHONE NUMPER ==============================
      //========================================================================
    } else {
      if (firstNameController.text.isNotEmpty) {
        profile.firstName = firstNameController.text;
        print('11111111');
      }
      if (lastNameController.text.isNotEmpty) {
        profile.lastName = lastNameController.text;
        print('2222222');
      }
      if (birthDateController.text.isNotEmpty) {
        profile.dateOfBirth = birthDateController.text;
        print('3333333');
      }
      http.Response response = await posts(
        url: 'http://10.0.2.2:8000/api/v1/user/complete-profile',
        body: {
          'first_name': profile.firstName,
          'last_name': profile.lastName,
          'phone_number': phoneController.text,
          'date_of_birth': profile.dateOfBirth,
          'address': profile.address,
          'city': 'aa',
        },
        token: access_token,
      );

      if (response.statusCode != 200) {
        Map<String, dynamic> error = jsonDecode(response.body);
        print(error);

        if (error["message"] ==
            "The date of birth field must be a date before today.") {
          UiHelper.showAlert(
            context: context,
            title: 'ERROR',
            content: "The date of birth field must be a date before today.",
          );
          return;
        }
        if (error["errors"]["phone_number"][0] ==
            "The phone number has already been taken.") {
          UiHelper.showAlert(
            context: context,
            title: 'ERROR',
            content: "The phone number has already been taken.",
          );
          return;
        }
        return;
      }

      profile.phoneNumber = phoneController.text;
      Navigator.pop(context);
      UiHelper.showAlert(
        context: context,
        title: 'Success',
        content: 'Yor inforation has been updated',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(color: offWhite, height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Backbotton(),
                VerticalDivider(width: 85, color: offWhite),
                const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                VerticalDivider(width: 135, color: offWhite),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await _profileLogic.pickImage(context, () {
                            setState(
                              () {},
                            ); // إعادة بناء الواجهة بعد اختيار الصورة
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(
                            255,
                            252,
                            193,
                            104,
                          ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: UiHelper.buildSectionTitle('UserName'),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomNameTextField(
                              controller: firstNameController,
                              fieldName: profile.firstName,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomNameTextField(
                              controller: lastNameController,
                              fieldName: profile.lastName,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: UiHelper.buildSectionTitle('Phone Number'),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomPhoneTextField(
                        controller: phoneController,
                        number: profile.phoneNumber,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: UiHelper.buildSectionTitle('Birth-Date'),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomDatePickerField(
                        controller: birthDateController,
                        fieldName: profile.dateOfBirth,
                        datePickerLogic: _datePickerLogic,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditlcationScreen(
                                  profile: profile,
                                  access_token: access_token,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Edit Location  ',
                          style: TextStyle(fontSize: 17, color: yellow),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        textOfButton: 'Save',
                        onPressed: _handleConfirm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
