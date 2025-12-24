import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class CustomPhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  String? number;
  CustomPhoneTextField({Key? key, required this.controller, this.number})
    : super(key: key);

  @override
  _CustomPhoneTextFieldState createState() =>
      _CustomPhoneTextFieldState(number: number);
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  String? number;
  _CustomPhoneTextFieldState({this.number});
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;
  String? _errorText;

  void _validatePhoneNumber(String value) {
    setState(() {
      if (value.isEmpty) {
        _hasError = false;
        _errorText = null;
      } else if (!RegExp(r'^\d+$').hasMatch(value)) {
        _hasError = true;
        _errorText = 'Phone number can only contain digits';
      } else if (value.length != 10) {
        _hasError = true;
        _errorText = 'Phone number must be 10 digits';
      } else {
        _hasError = false;
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      focusNode: _focusNode,
      cursorHeight: 20,
      cursorColor: darkBlack,
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: _errorText,
        suffixIcon: Icon(Icons.phone),
        suffixIconColor: _hasError ? red : greydark,
        labelText: number != null ? number : 'Number',
        labelStyle: const TextStyle(color: Colors.black38, fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(
          fontSize: 20,
          color: _hasError ? red : yellow,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: yellow, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: _hasError ? yellow : greydark,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: _hasError ? red : Colors.grey,
            width: 2,
          ),
        ),
      ),
      onChanged: _validatePhoneNumber,
    );

    // TextField(
    //   decoration: InputDecoration(
    //     border: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: _hasError ? Colors.red : Colors.grey,
    //         width: 3.0,
    //       ),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: _hasError ? Colors.red : yellow,
    //         width: 3.0,
    //       ),
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: _hasError ? yellow : grey,
    //         width: 3.0,
    //       ),
    //     ),
    //     errorText: _errorText,
    //   ),
    //   style: TextStyle(
    //     fontFamily: 'Sofia',
    //     fontSize: 16,
    //   ),
    //   onChanged:,
    // );
  }
}
