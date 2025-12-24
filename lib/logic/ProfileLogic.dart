import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/logic/DatePickerLogic.dart';
import 'package:delivery_app/model/profile.dart';

class ProfileLogic {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final DatePickerLogic datePickerLogic = DatePickerLogic();
  File? profileImage;

  // اختيار الصورة
  Future<void> pickImage(BuildContext context, Function() onImagePicked) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      backgroundColor: offWhite,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: yellow, size: 35),
              title: Text(
                'Choose from gallery',
                style: UiHelper.TextStyleGeneral,
              ),
              onTap: () async {
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  profileImage = File(pickedFile.path);
                  Navigator.pop(context);
                  onImagePicked(); // استدعاء التحديث
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: yellow, size: 35),
              title: Text('Take a photo', style: UiHelper.TextStyleGeneral),
              onTap: () async {
                final pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  profileImage = File(pickedFile.path);
                  Navigator.pop(context);
                  onImagePicked(); // استدعاء التحديث
                }
              },
            ),
          ],
        );
      },
    );
  }

  // التأكد من صحة الإدخالات قبل الحفظ
  void handleConfirm(
    BuildContext context, {
    required String access_token,
    required Profile profile,
    required Function(Profile profile) onSuccess,
  }) async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        birthDateController.text.isEmpty ||
        profileImage == null) {
      UiHelper.showAlert(
        context: context,
        title: 'Error',
        content: profileImage == null
            ? 'Please select a profile picture before proceeding.'
            : 'Please fill in all the fields before proceeding.',
      );
      return;
    } else {
      http.Response response = await posts(
        url: 'http://10.0.2.2:8000/api/v1/user/complete-profile',
        body: {
          'first_name': profile.firstName,
          'last_name': profile.lastName,
          'phone_number': profile.phoneNumber,
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
    }
    onSuccess(profile);
  }

  // تنظيف الموارد عند انتهاء الاستخدام
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
  }
}
