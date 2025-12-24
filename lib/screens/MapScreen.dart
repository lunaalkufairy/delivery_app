import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/ProductList.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/HomeScreen.dart';
import 'package:delivery_app/service/getProfile.dart';

class MapScreen extends StatefulWidget {
  final Profile profile;
  final String access_token;
  MapScreen({required this.profile, required this.access_token});

  @override
  _MapScreenState createState() =>
      _MapScreenState(access_token: access_token, profile: profile);
}

class _MapScreenState extends State<MapScreen> {
  Profile profile; // كلمة المرور المُدخلة
  final String access_token;
  _MapScreenState({required this.profile, required this.access_token});
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  // Add more states and their cities here

  List<String> currentCities = [];

  void _showStateDialog(BuildContext context) {
    final List<String> syrianStates = citiesByState.keys.toList();

    UiHelper.showAlertWithList(
      context: context,
      title: "Select Your State",
      items: syrianStates,
      onItemSelected: (String selectedState) {
        setState(() {
          stateController.text = selectedState;
          currentCities = citiesByState[selectedState] ?? [];
          cityController.clear(); // Clear the city field when state changes
        });
      },
    );
  }

  void _showCityDialog(BuildContext context) {
    if (currentCities.isEmpty) {
      UiHelper.showAlert(
        context: context,
        title: "No Cities",
        content: "Please select a state first to view cities.",
      );
      return;
    }

    UiHelper.showAlertWithList(
      context: context,
      title: "Select Your City",
      items: currentCities,
      onItemSelected: (String selectedCity) {
        setState(() {
          cityController.text = selectedCity;
        });
      },
    );
  }

  void _showStreetDialog(BuildContext context) {
    final List<String> streetNumbers = List.generate(
      30,
      (index) => (index + 1).toString(),
    );

    UiHelper.showAlertWithList(
      context: context,
      title: "Select Street Number",
      items: streetNumbers,
      onItemSelected: (String selectedStreetNumber) {
        streetController.text = selectedStreetNumber;
      },
    );
  }

  void _handleConfirm(BuildContext context) async {
    if (stateController.text.isEmpty ||
        cityController.text.isEmpty ||
        streetController.text.isEmpty) {
      UiHelper.showAlert(
        context: context,
        title: "Error",
        content: "Please fill in all fields before confirming!",
      );
      return;
    }

    // تحديث الكائن النهائي
    profile.address =
        '${stateController.text} ${cityController.text} ${streetController.text}';
    print(profile.firstName);
    print(profile.lastName);
    print(profile.dateOfBirth);
    print(profile.email);
    print(profile.phoneNumber);
    print(profile.address);
    print(profile.profileImage);

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
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      print('QQQQQQQQQ555555555');

      profile = await fetchProfile(access_token);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeScreen(profile: profile, access_token: access_token),
        ),
      );
    } else {
      Map<String, dynamic> error = jsonDecode(response.body);
      print(error);
    }
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
              SizedBox(height: 40),
              Align(alignment: Alignment.topLeft, child: Backbotton()),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    ' assets/images/map.png',
                    fit: BoxFit.contain,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 30),
              UiHelper.buildSectionTitle('State'),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _showStateDialog(context),
                child: AbsorbPointer(
                  child: CustomNameTextField(
                    controller: stateController,
                    fieldName: 'State',
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                      color: darkBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              UiHelper.buildSectionTitle('City'),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _showCityDialog(context),
                child: AbsorbPointer(
                  child: CustomNameTextField(
                    controller: cityController,
                    fieldName: 'City',
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                      color: darkBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              UiHelper.buildSectionTitle('Street'),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _showStreetDialog(context),
                child: AbsorbPointer(
                  child: CustomNameTextField(
                    controller: streetController,
                    fieldName: 'Street',
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                      color: darkBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: CustomButton(
                  textOfButton: 'Confirm',
                  onPressed: () => _handleConfirm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
