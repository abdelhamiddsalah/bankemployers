import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class ProrgessIndecatorInEmployerSignup extends StatelessWidget {
  const ProrgessIndecatorInEmployerSignup({
    super.key,
    required int currentStep,
  }) : _currentStep = currentStep;

  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registration Progress',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                (int step, String title, String subtitle) {
          bool isActive = step <= _currentStep;
          return Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: isActive
                      ? Icon(Icons.check, color: maincolor, size: 20)
                      : Text(
                          '${step + 1}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          );
        }(0, 'Personal', 'Info'),
                (int step) {
          bool isActive = step < _currentStep;
          return Expanded(
            child: Container(
              height: 2,
              margin: EdgeInsets.only(bottom: 40),
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
            ),
          );
        }(0),
                (int step, String title, String subtitle) {
          bool isActive = step <= _currentStep;
          return Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: isActive
                      ? Icon(Icons.check, color: maincolor, size: 20)
                      : Text(
                          '${step + 1}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          );
        }(1, 'Contact', 'Details'),
                (int step) {
          bool isActive = step < _currentStep;
          return Expanded(
            child: Container(
              height: 2,
              margin: EdgeInsets.only(bottom: 40),
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
            ),
          );
        }(1),
                (int step, String title, String subtitle) {
          bool isActive = step <= _currentStep;
          return Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: isActive
                      ? Icon(Icons.check, color: maincolor, size: 20)
                      : Text(
                          '${step + 1}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          );
        }(2, 'Employment', 'Info'),
              ],
            ),
          ],
        );
  }
}