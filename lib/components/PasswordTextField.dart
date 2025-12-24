import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? textStyle;

  const PasswordTextField({
    Key? key,
    required this.controller,
    this.hintText = 'Password',
    this.textStyle,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;
  late FocusNode _focusNode;
  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isEmpty = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      focusNode: _focusNode,
      cursorColor: yellow,
      onChanged: (value) {
        setState(() {
          _isEmpty = value.isEmpty;
        });
      },
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(color: greydark, fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(fontSize: 20, color: yellow),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: greydark, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: yellow, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: _isEmpty ? red : greydark, width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: greydark,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      style:
          widget.textStyle ??
          TextStyle(fontFamily: 'Sofia', fontSize: 16, color: Colors.black),
    );
  }
}
