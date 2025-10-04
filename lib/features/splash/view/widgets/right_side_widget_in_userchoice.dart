import 'package:flutter/material.dart';

class RightSideWidgetInUserChoice extends StatelessWidget {
  const RightSideWidgetInUserChoice( {
    Key? key,
    required this.isMobile,
    required this.constraints, required this.fadeAnimation,
  }) : super(key: key);
  final bool isMobile;
  final BoxConstraints constraints;
  final Animation<double> fadeAnimation;
  @override
  Widget build(BuildContext context) {
    return isMobile
        ? Container(
            width: constraints.maxWidth,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bank Logo/Icon
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.account_balance,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Main Title
                  Text(
                    'Bank Management System',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Secure, Efficient, and User-Friendly Banking Solution',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(60),
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bank Logo/Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.account_balance,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),

                    // Main Title
                    Text(
                      'Bank Management\nSystem',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Subtitle
                    Text(
                      'Secure, Efficient, and User-Friendly\nBanking Solution for Modern Institutions',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40),

                    // Features List
                    () {
                      final features = [
                        'Advanced Security Protocols',
                        'Real-time Transaction Processing',
                        'Comprehensive User Management',
                        'Detailed Analytics & Reports',
                      ];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: features.map((feature) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 20,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }(),
                  ],
                ),
              ),
            ),
          );
  }
}
