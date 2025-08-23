import 'package:bankemployers/features/auth/widgets/progress_indecator_in_employersignup.dart';
import 'package:flutter/material.dart';

class LeftSideInEmployerSignup extends StatelessWidget {
  const LeftSideInEmployerSignup({
    super.key,
    required AnimationController animationController,
    required Animation<double> fadeAnimation,
    required int currentStep,
  }) : _animationController = animationController, _fadeAnimation = fadeAnimation, _currentStep = currentStep;

  final AnimationController _animationController;
  final Animation<double> _fadeAnimation;
  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(60),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_add,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Join Our\nTeam',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Create your employee account and become part of our digital banking platform. Fill in your details to get started.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40),
                  ProrgessIndecatorInEmployerSignup(currentStep: _currentStep),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

