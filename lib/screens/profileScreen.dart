import 'package:flutter/material.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/components/profileContainer.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/EditProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  final Profile profile;

  final String access_token;

  const ProfileScreen({
    super.key,
    required this.profile,
    required this.access_token,
  });

  @override
  Widget build(BuildContext context) {
    // معالجة العنوان ليكون نصًا يمكن عرضه

    return Scaffold(
      backgroundColor: offWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(color: offWhite, height: 55),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Backbotton(),
                VerticalDivider(width: 80, color: offWhite),
                Container(
                  width: 130,
                  child: Text(
                    'User profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                VerticalDivider(width: 130, color: offWhite),
              ],
            ),
            Divider(color: offWhite, height: 15),
            CircleAvatar(
              radius: 100,
              child: profile.profileImage == null
                  ? Icon(Icons.person, size: 50, color: grey)
                  : null,
            ),
            SizedBox(height: 15),
            Container(
              height: 30,
              child: Text(
                ' ${profile.firstName} ${profile.lastName}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 35,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditprofileScreen(
                          profile: profile,
                          access_token: access_token,
                        );
                      },
                    ),
                  );
                },
                child: Text('Edit profile', style: TextStyle(color: yellow)),
              ),
            ),
            Profilecontainer(
              upText: 'Email',
              inText: profile.email,
              icon: Icons.email_outlined,
            ),
            SizedBox(height: 18),
            Profilecontainer(
              upText: 'Phone Number',
              inText: profile.phoneNumber,
              icon: Icons.phone,
            ),
            SizedBox(height: 18),
            Profilecontainer(
              upText: 'Birth Day',
              inText: profile.dateOfBirth,
              icon: Icons.date_range,
            ),
            SizedBox(height: 18),
            Profilecontainer(
              upText: 'Location',
              inText: profile.address,
              icon: Icons.location_on_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
