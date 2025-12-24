import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class SideBarBotton extends StatefulWidget {
  const SideBarBotton({super.key});

  @override
  State<SideBarBotton> createState() => _SideBarBottonState();
}

class _SideBarBottonState extends State<SideBarBotton> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
            child: Icon(Icons.format_list_bulleted_rounded, size: 25),
          ),
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    );
  }
}
