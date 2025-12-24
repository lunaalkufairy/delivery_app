class User {
  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String profileImage;
  final List<dynamic> locations;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.profileImage,
    required this.locations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      profileImage: json['profile_image'],
      locations: json['locations'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'profile_image': profileImage,
      'locations': locations,
    };
  }
}

class UserProfileResponse {
  final User profile;

  UserProfileResponse({required this.profile});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      profile: User.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile.toJson(),
    };
  }
}
