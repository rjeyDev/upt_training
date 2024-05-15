import 'package:flutter/material.dart';

class ScaledSize {
  // Convert figma size to device size
  static double text(BuildContext context, double size) {
    var scale = 1.0;

    final screenSize = MediaQuery.of(context).size;
//    var physicalPixelWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;

    if (screenSize.height <= 320 || screenSize.width <= 320) {
      scale = 0.6;
    }
    if (screenSize.width <= 300 || screenSize.height <= 812) {
      scale = 0.8;
    }
    if (screenSize.width > 375) {
      scale = 1.05;
    }
    if (screenSize.width <= 420) {
      scale = 0.9;
    }

    final newSize = (size * scale).toDouble();
    return newSize;
  }

  // Convert ui (button, logo) sizes to device size
  static double widget(BuildContext context, double size) {
    // Change the logic if needs difference
    var scale = 1.0;

    final screenSize = MediaQuery.of(context).size;
//    var physicalPixelWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;

    if (screenSize.height <= 320) {
      scale = 0.85;
    }
    if (screenSize.width <= 320) {
      scale = 0.85;
    }
    if (screenSize.width <= 300) {
      scale = 0.8;
    }
    if (screenSize.width > 375) {
      scale = 1.1;
    }

    // if (screenSize.width <= 420) {
    //   scale = 0.85;
    // }
    // if (screenSize.width <= 520) {
    //   scale = 0.90;
    // }
    // if(screenSize.width > 375){
    //   scale = 1.05;
    // }

    final newSize = (size * scale).round().toDouble();
    return newSize;
  }

  // Convert banner in the intro/intro_carousel_screen
  static double banner(BuildContext context, double size) {
    var scale = 1.0;

    final screenSize = MediaQuery.of(context).size;
    if (screenSize.width <= 320) {
      scale = 0.8;
    }
    if (screenSize.width <= 300) {
      scale = 0.8;
    }
    if (screenSize.height <= 812) {
      scale = 0.95;
    }
    final newSize = (size * scale).round().toDouble();

    return newSize;
  }

  // Horizontal padding
  static double horizontalPadding(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (screenSize.width <= 320) {
      return 16;
    }
    return 32;
  }

  static double scale(BuildContext context, double size) {
    final screenSize = MediaQuery.of(context).size;

    return screenSize.width / 375 * size;
  }
}
