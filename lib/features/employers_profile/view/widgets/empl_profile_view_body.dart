import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/employers_profile/view/widgets/about_company.dart';
import 'package:bankemployers/features/employers_profile/view/widgets/definatin_in_profile.dart';
import 'package:bankemployers/features/employers_profile/view/widgets/header_in_profile.dart';
import 'package:flutter/material.dart';

class EmplProfileViewBody extends StatelessWidget {
  const EmplProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            HeaderInProfile(),
            const SizedBox(height: 40),
            // Profile Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  // Company Logo and Name
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: maincolor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.apartment,
                          size: 50,
                          color: maincolor,
                        ),
                      ),
                      const SizedBox(width: 24),
                      DefinationInProfile(),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 32),
                  // Company Information
                  _buildInfoRow(
                    Icons.business,
                    'Industry',
                    'Information Technology',
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    Icons.people,
                    'Company Size',
                    '500-1000 Employees',
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    Icons.location_on,
                    'Location',
                    'Cairo, Egypt',
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    Icons.email,
                    'Email',
                    'contact@techsolutions.com',
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    Icons.phone,
                    'Phone',
                    '+20 123 456 7890',
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    Icons.language,
                    'Website',
                    'www.techsolutions.com',
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  // About Section
                  AboutCompany(),
                ],
              ),
            ),          
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: maincolor, size: 22),
        const SizedBox(width: 16),
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
