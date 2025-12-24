import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class Backbotton extends StatelessWidget {
  const Backbotton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: yellow.withOpacity(0.2),
              spreadRadius: 0.05,
              blurRadius: 10,
              offset: Offset(7, 7),
            ),
          ],
          color: offWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        width: 50,
        child: Icon(
          Icons.arrow_back_rounded,
          color: const Color.fromARGB(231, 0, 0, 0),
          size: 27,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
