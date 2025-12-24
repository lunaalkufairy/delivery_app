import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class StoreContainer extends StatelessWidget {
  final String storeImage;
  const StoreContainer({required this.storeImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(19),
          image: DecorationImage(
            image: AssetImage(storeImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
