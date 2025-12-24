import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:delivery_app/components/introduction1.dart';
import 'package:delivery_app/components/introduction3.dart';
import 'package:delivery_app/components/introduction2.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/screens/LoginScreen.dart';

class Introductionscreen extends StatelessWidget {
  const Introductionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        image: Introduction1(),
        body: '',
        title: '',
        footer: Text(''),
        decoration: PageDecoration(
          fullScreen: true,
          bodyAlignment: Alignment(1, 1),
        ),
      ),
      PageViewModel(
        image: Introduction2(),
        body: '',
        title: '',
        footer: Text(''),
        decoration: PageDecoration(
          fullScreen: true,
          bodyAlignment: Alignment(1, 1),
        ),
      ),
      PageViewModel(
        image: Introduction3(),
        body: '',
        title: '',
        footer: Text(''),
        decoration: PageDecoration(
          fullScreen: true,
          bodyAlignment: Alignment(1, 1),
        ),
      ),
    ];
    return IntroductionScreen(
      globalBackgroundColor: offWhite,
      //=========================================================================
      //=========================================================================
      //=========================================================================
      done: Text(
        'Done',
        style: TextStyle(
          color: offWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
      },
      //=========================================================================
      //=========================================================================
      //=========================================================================
      next: Text(
        'Next',
        style: TextStyle(
          color: darkBlack,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      //=========================================================================
      //=========================================================================
      //=========================================================================
      skip: Text(
        'skip',
        style: TextStyle(
          color: darkBlack,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      showSkipButton: true,
      onSkip: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
      },

      //=========================================================================
      //=========================================================================
      //=========================================================================
      pages: pages,
      dotsDecorator: DotsDecorator(
        color: darkBlack.withOpacity(0.5),
        activeColor: darkBlack,
      ),
    );
  }
}
