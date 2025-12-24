import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class Introduction3 extends StatelessWidget {
  const Introduction3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,

      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment(0, 1),
            child: Image(image: AssetImage('assets/images/Asset 4@4x.png')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70.0),
            child: Container(
              height: 450,
              width: 450,
              child: Container(
                child: Image(image: AssetImage('assets/images/Asset 1@4x.png')),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 660.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment(0, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'DELIVERD',
                    style: TextStyle(
                      color: offWhite,
                      fontSize: 47,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Your prouducts comes \n         at your door',
                      style: TextStyle(
                        color: offWhite,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      //  Stack(
      //   children: [
      //     Container(
      //         alignment: Alignment(0, -0.7),
      //         color: Colors.blue,
      //         height: double.infinity,
      //         width: double.infinity,
      //         child: Column(
      //           children: [
      //             Container(
      //               height: 360,
      //               width: 300,
      //               decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                       fit: BoxFit.fill,
      //                       image: AssetImage('assets/images/3.png'))),
      //             ),
      //             Container(
      //                 height: 300,
      //                 width: 300,
      //                 decoration: BoxDecoration(
      //                   color: Colors.yellow,
      //                   shape: BoxShape.values[3],
      //                 ))
      //           ],
      //         )),
      //   ],
      // ),
    );
  }
}
