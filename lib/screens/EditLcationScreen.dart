import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/CustomNameTextField.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/model/ProductList.dart';
import 'package:delivery_app/model/profile.dart';

class EditlcationScreen extends StatefulWidget {
  final Profile profile;
  final String access_token;

  EditlcationScreen({required this.profile, required this.access_token});

  @override
  State<EditlcationScreen> createState() =>
      _EditlcationScreenState(profile: profile, access_token: access_token);
}

class _EditlcationScreenState extends State<EditlcationScreen> {
  final Profile profile;
  final String access_token;

  _EditlcationScreenState({required this.profile, required this.access_token});

  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

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

  List<String> currentCities = [];
  void _showCityDialog(BuildContext context) {
    UiHelper.showAlertWithList(
      context: context,
      title: "Select Your City",
      items: currentCities,
      onItemSelected: (String selectedCity) {
        cityController.text = selectedCity;
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
              SizedBox(height: 30),

              // صورة الخريطة
              Center(
                child: Container(
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4), // الظل يظهر أسفل الصورة
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        'assets/images/map.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),

              // اختيار الدولة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: UiHelper.buildSectionTitle('Select your State'),
              ),
              SizedBox(height: 14),
              GestureDetector(
                onTap: () => _showStateDialog(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AbsorbPointer(
                    child: CustomNameTextField(
                      controller: stateController,
                      fieldName: 'State',
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // اختيار المدينة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: UiHelper.buildSectionTitle('Select your City'),
              ),
              SizedBox(height: 14),
              GestureDetector(
                onTap: () => _showCityDialog(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AbsorbPointer(
                    child: CustomNameTextField(
                      controller: cityController,
                      fieldName: 'City',
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // اختيار الشارع
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: UiHelper.buildSectionTitle('Select your Street'),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _showStreetDialog(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AbsorbPointer(
                    child: CustomNameTextField(
                      controller: streetController,
                      fieldName: 'Street',
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),

              // زر الحفظ
              Center(
                child: CustomButton(
                  textOfButton: 'Save',
                  onPressed: () async {
                    if (stateController.text.isEmpty &&
                        cityController.text.isEmpty &&
                        streetController.text.isEmpty) {
                      UiHelper.showAlert(
                        context: context,
                        title: 'Error',
                        content: 'No information to update',
                      );
                    }
                    if (stateController.text.isEmpty ||
                        cityController.text.isEmpty ||
                        streetController.text.isEmpty) {
                      UiHelper.showAlert(
                        context: context,
                        title: 'Error',
                        content: 'Enter a valid location',
                      );
                    } else {
                      setState(() {
                        profile.address =
                            '${stateController.text} ${cityController.text} ${streetController.text}';
                      });

                      print(profile.address);

                      http.Response response = await posts(
                        url:
                            'http://10.0.2.2:8000/api/v1/user/complete-profile',
                        body: {
                          'first_name': profile.firstName,
                          'last_name': profile.lastName,
                          'date_of_birth': profile.dateOfBirth,
                          'address': profile.address,
                          'city': 'aa',
                        },
                        token: access_token,
                      );
                      Navigator.pop(context);
                      UiHelper.showAlert(
                        context: context,
                        title: 'Success',
                        content: 'The location has been updated',
                      );
                    }
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
