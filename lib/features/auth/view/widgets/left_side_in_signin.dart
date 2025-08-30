import 'package:flutter/material.dart';

class LeftSideInSignin extends StatelessWidget {
  const LeftSideInSignin({
    super.key,
    required AnimationController animationController,
    required Animation<double> fadeAnimation,
  }) : _animationController = animationController, _fadeAnimation = fadeAnimation;

  final AnimationController _animationController;
  final Animation<double> _fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
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
                    Icons.account_balance,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Digital Bank\nSystem',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Secure and efficient banking platform for employees. Access your account and manage banking operations with ease.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Row(
          children: [
            Text('🔒', style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            Text(
              'Secure Login',
              style: TextStyle(
    color: Colors.white.withOpacity(0.9),
    fontSize: 16,
              ),
            ),
          ],
        ),
                      SizedBox(width: 30),
                      Row(
          children: [
            Text('⚡', style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            Text(
              'Fast Access',
              style: TextStyle(
    color: Colors.white.withOpacity(0.9),
    fontSize: 16,
              ),
            ),
          ],
        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
          children: [
            Text('📊', style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            Text(
              'Real-time Data',
              style: TextStyle(
    color: Colors.white.withOpacity(0.9),
    fontSize: 16,
              ),
            ),
          ],
        ),
                      SizedBox(width: 30),
                      Row(
          children: [
            Text('🛡️', style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            Text(
              'Protected',
              style: TextStyle(
    color: Colors.white.withOpacity(0.9),
    fontSize: 16,
              ),
            ),
          ],
        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}