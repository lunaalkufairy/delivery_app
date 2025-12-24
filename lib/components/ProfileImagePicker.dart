// import 'package:flutter/material.dart';
// import 'dart:io'; // للتأكد من التعامل مع الصور كملف
// import 'package:delivery_app/model/ProfileLogic.dart';

// class ProfileImagePicker extends StatelessWidget {
//   final ProfileLogic profileLogic;

//   const ProfileImagePicker({
//     Key? key,
//     required this.profileLogic,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         profileLogic.pickImage(context);
//       },
//       child: CircleAvatar(
//         radius: 100,
//         backgroundImage: profileLogic.profileImage != null
//             ? FileImage(profileLogic.profileImage!)
//             : null,
//         child: profileLogic.profileImage == null
//             ? const Icon(Icons.account_circle, color: Colors.black, size: 200)
//             : null,
//       ),
//     );
//   }
// }
