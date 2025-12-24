import 'dart:io';

class Profile {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String profileImage;
  File? fileProfileImage;
  String address;

  Profile(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.profileImage,
      required this.address,
      this.fileProfileImage});

  // Factory constructor to create a Profile object from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      profileImage: json['profile_image'],
      address: json['locations'] != null && json['locations'].isNotEmpty
          ? json['locations'][0]['address']
          : '',
    );
  }
}
