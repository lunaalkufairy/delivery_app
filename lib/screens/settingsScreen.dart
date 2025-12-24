import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';

class Settingsscreen extends StatefulWidget {
  Settingsscreen({super.key});

  @override
  State<Settingsscreen> createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
  final TextEditingController languageController = TextEditingController();
  final TextEditingController moodController = TextEditingController();
  String selectlanguage = 'English';
  String selectmood = 'Light Mood';

  void _showLanguageDialog(BuildContext context) {
    final List<String> languages = ['Arabic', 'English'];

    UiHelper.showAlertWithList(
      context: context,
      title: "Select Your Language",
      items: languages,
      onItemSelected: (String selectedLanguage) {
        setState(() {
          selectlanguage = selectedLanguage;
        });
      },
    );
  }

  void _showmoodDialog(BuildContext context) {
    final List<String> moods = ['Light Mood', 'Dark Mood'];

    UiHelper.showAlertWithList(
      context: context,
      title: "Select Your Theme Mood",
      items: moods,
      onItemSelected: (String selectedMood) {
        setState(() {
          selectmood = selectedMood;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    languageController.text = selectlanguage;
    moodController.text = selectmood;
    return Scaffold(
      backgroundColor: offWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Backbotton(),
                VerticalDivider(width: 100, color: offWhite),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                VerticalDivider(width: 135, color: offWhite),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: UiHelper.buildSectionTitle('Language'),
                ),
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () => _showLanguageDialog(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: AbsorbPointer(
                  child: CustomNameTextField(
                    controller: languageController,
                    fieldName: 'Language',
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                      color: darkBlack,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: UiHelper.buildSectionTitle('Theme Mood'),
                ),
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () => _showmoodDialog(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: AbsorbPointer(
                  child: CustomNameTextField(
                    controller: moodController,
                    fieldName: 'Theme Mood',
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                      color: darkBlack,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
