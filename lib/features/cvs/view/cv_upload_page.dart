import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/widgets/form_panal.dart';

import 'package:flutter/material.dart';

class CVUploadPage extends StatelessWidget {
  const CVUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left Panel - Hero Section
          Expanded(flex: 5, child: _buildHeroPanel()),
          // Right Panel - Form Section
          Expanded(flex: 7, child: FormPanel()),
        ],
      ),
    );
  }

  Widget _buildHeroPanel() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor, Color(0xFF8B5CF6)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.work_outline,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Join Our\nBanking Team',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Start your career journey with us. Upload your CV and let us know about your experience. We\'re looking for talented individuals to join our growing team.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            _buildFeatureList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      {'icon': Icons.star, 'text': 'Competitive Salary & Benefits'},
      {'icon': Icons.trending_up, 'text': 'Career Growth Opportunities'},
      {'icon': Icons.people, 'text': 'Collaborative Work Environment'},
      {'icon': Icons.school, 'text': 'Continuous Learning & Development'},
    ];

    return Column(
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      feature['icon'] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      feature['text'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

