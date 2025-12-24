import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';

class PrivacyChecker extends StatefulWidget {
  final Function(bool) onChecked;

  const PrivacyChecker({Key? key, required this.onChecked}) : super(key: key);

  @override
  _PrivacyCheckerState createState() => _PrivacyCheckerState();
}

class _PrivacyCheckerState extends State<PrivacyChecker> {
  bool _isChecked = false;

  void _toggleCheck(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChecked(_isChecked); // استدعاء الدالة لإرسال الحالة
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: _toggleCheck,
          activeColor: yellow,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I have read and agree to the ',
              style: UiHelper.TextStyleGeneral,
              children: [
                TextSpan(
                  text: 'Terms of Service ',
                  style: TextStyle(
                    fontFamily: 'Sofia',
                    color: yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: 'and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    fontFamily: 'Sofia',
                    color: yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
