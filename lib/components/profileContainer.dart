import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class Profilecontainer extends StatelessWidget {
  const Profilecontainer({
    required this.upText,
    required this.inText,
    required this.icon,
  });
  final String upText;
  final String inText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              upText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: offWhite,
              border: Border.all(color: yellow.withOpacity(0.8)),
              boxShadow: [
                BoxShadow(
                  color: yellow.withOpacity(0.3),
                  offset: Offset(0, 7),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 277,
                    child: Text(
                      inText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(icon, color: yellow.withOpacity(0.8), size: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
