// widgets/animated_background.dart
import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4338CA),
            maincolor,
            Color(0xFF8B5CF6),
          ],
        ),
      ),
      child: child,
    );
  }
}