import 'package:flutter/material.dart';

class OnBoardingRoundedTopShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height * 0.1185289);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.1185289);
    path.cubicTo(size.width * 0.1512695, size.height * 0.04256658,
        size.width * 0.3208667, 0, size.width * 0.5000000, 0);
    path.cubicTo(size.width * 0.6791333, 0, size.width * 0.8487308,
        size.height * 0.04256658, size.width, size.height * 0.1185289);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HomeHeroCardShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 4.446848, size.height * 0.4968354);
    path.cubicTo(
        size.width * 4.446848,
        size.height * 1.807532,
        size.width * 3.453450,
        size.height * 2.870253,
        size.width * 2.227813,
        size.height * 2.870253);
    path.cubicTo(
        size.width * 1.002170,
        size.height * 2.870253,
        size.width * 0.008771930,
        size.height * 1.807532,
        size.width * 0.008771930,
        size.height * 0.4968354);
    path.cubicTo(
        size.width * 0.008771930,
        size.height * -0.8138608,
        size.width * 1.002170,
        size.height * -1.876582,
        size.width * 2.227813,
        size.height * -1.876582);
    path.cubicTo(
        size.width * 3.453450,
        size.height * -1.876582,
        size.width * 4.446848,
        size.height * -0.8138608,
        size.width * 4.446848,
        size.height * 0.4968354);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
