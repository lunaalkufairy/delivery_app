import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:delivery_app/screens/LoginScreen.dart';
import 'package:delivery_app/screens/splashScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
