import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red value
    random.nextInt(256), // Green value
    random.nextInt(256), // Blue value
    1.0, // Opacity
  );
}
