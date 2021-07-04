import 'package:flutter/material.dart';

class GradientBackground {
  static LinearGradient gradient({double type = 0}) {
    if (type == 0) {
      return LinearGradient(colors: [Color(0xFF3195F0), Color(0xFF3294ED), Color(0xFF2584DB)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    }
    if (type == 1) {
      return LinearGradient(colors: [Color(0xFF15DBAB), Color(0xFF18CAB4), Color(0xFF1DB2C2), Color(0xFF3095F1)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    }
  }
}
