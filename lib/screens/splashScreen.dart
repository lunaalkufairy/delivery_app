import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/screens/IntroductionScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      useImmersiveMode: true,
      duration: Duration(milliseconds: 5000),
      nextScreen: Introductionscreen(),
      backgroundColor: yellow,
      splashScreenBody: Center(
        child: Lottie.asset('assets/images/Animation - 1735823804094.json'),
      ),
    );
  }
}
