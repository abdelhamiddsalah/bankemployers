
import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class AboutCompany extends StatelessWidget {
  const AboutCompany({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: maincolor),
              const SizedBox(width: 12),
              const Text(
                'About Company',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'We are a leading technology company specializing in innovative software solutions. Our mission is to empower businesses through cutting-edge technology and exceptional service. With over 10 years of experience, we have built a strong reputation for delivering high-quality products and services to clients worldwide.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}