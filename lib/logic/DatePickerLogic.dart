import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class DatePickerLogic {
  //  to open dilog allow the user to select the date
  Future<String?> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: yellow,
            colorScheme: ColorScheme.light(
              primary: yellow,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      return "${pickedDate.toLocal()}".split(' ')[0];
    }
    return null;
  }
}
