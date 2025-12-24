import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class Introduction2 extends StatelessWidget {
  const Introduction2({super.key});

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
            alignment: Alignment(0, -1),
            child: Image(image: AssetImage('assets/images/Asset 6@4x.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 340.0),
            child: Container(
              height: 450,
              width: 450,
              child: Container(
                child: Image(image: AssetImage('assets/images/Asset 5@4x.png')),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment(0, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'TRACK YOUR',
                    style: TextStyle(
                      color: offWhite,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ORDER',
                    style: TextStyle(
                      color: offWhite,
                      fontSize: 40,
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
