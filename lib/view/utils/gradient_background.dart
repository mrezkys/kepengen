import 'package:flutter/material.dart';

class GradientBackground {
  static LinearGradient gradient({double rotation = 0}) => (rotation == 0)
      ? LinearGradient(colors: [Color(0xFF3195F0), Color(0xFF3294ED), Color(0xFF2584DB)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
      : LinearGradient(colors: [Color(0xFF3195F0), Color(0xFF3294ED), Color(0xFF2584DB)], begin: Alignment.topLeft, end: Alignment.topRight);
}
