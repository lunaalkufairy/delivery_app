import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<Slider> {
  late final List<String> imgList = [
    'assets/images/ball.jpg',
    'assets/images/ball.jpg',
    'assets/images/ball.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: imgList
            .map((item) => Container(
                  child: Center(
                    child: Image(image: AssetImage(item)),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            autoPlay: true, aspectRatio: 2, enlargeCenterPage: true));
  }
}
