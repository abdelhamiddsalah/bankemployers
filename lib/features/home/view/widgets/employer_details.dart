import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/home/data/model/employers_model.dart';
import 'package:flutter/material.dart';

class EmployerDetailsPage extends StatelessWidget {
  const EmployerDetailsPage({
    super.key,
    required this.employer,
  }); // ✅ Added const
  final EmployersModel employer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: maincolor,
        elevation: 0,
        title: const Text(
          'Employee Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Profile
            _buildProfileHeader(),
            const SizedBox(height: 32),
    
            // Details Sections
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    children: [
                      _buildPersonalInfoCard(),
                      const SizedBox(height: 24),
                      _buildContactInfoCard(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
    
                // Right Column
                Expanded(
                  child: Column(
                    children: [
                      _buildJobInfoCard(),
                      const SizedBox(height: 24),
                      _buildSecurityInfoCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [maincolor, maincolor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: maincolor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(Icons.person, size: 60, color: maincolor),
          ),
          const SizedBox(width: 32),

          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${employer.firstName ?? 'N/A'} ${employer.lastName ?? 'N/A'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  employer.jobTitle ?? 'No Job Title',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employer.department ?? 'No Department',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'ID: ${employer.emplyeeID ?? 'N/A'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return _buildInfoCard('Personal Information', Icons.person_outline, [
      _buildInfoRow('First Name', employer.firstName ?? 'N/A'),
      _buildInfoRow('Last Name', employer.lastName ?? 'N/A'),
      _buildInfoRow('National ID', employer.nationalID ?? 'N/A'),
      _buildInfoRow('Date of Birth', _formatDate(employer.dateOfBirth)),
      _buildInfoRow('Gender', _formatGender(employer.gender)),
      _buildInfoRow(
        'Marital Status',
        _translateMaterialStatus(employer.materialStatus),
      ),
    ]);
  }

  Widget _buildContactInfoCard() {
    return _buildInfoCard('Contact Information', Icons.contact_phone_outlined, [
      _buildInfoRow('Email', employer.email ?? 'N/A'),
      _buildInfoRow('Phone Number', employer.phoneNumber ?? 'N/A'),
      _buildInfoRow('City', employer.address?.city ?? 'N/A'),
      _buildInfoRow('Zip Code', employer.address?.zipCode ?? 'N/A'),
    ]);
  }

  Widget _buildJobInfoCard() {
    return _buildInfoCard('Job Information', Icons.work_outline, [
      _buildInfoRow('Job Title', employer.jobTitle ?? 'N/A'),
      _buildInfoRow('Department', employer.department ?? 'N/A'),
      _buildInfoRow('Work Branch', employer.workBranch ?? 'N/A'),
      _buildInfoRow('Hiring Date', _formatDate(employer.dateOfHiring)),
      _buildInfoRow('Role', employer.role),
    ]);
  }

  Widget _buildSecurityInfoCard() {
    return _buildInfoCard('Security Information', Icons.security_outlined, [
      _buildInfoRow('Employee ID', employer.id.toString()),
      _buildInfoRow('Employee Code', employer.emplyeeID ?? 'N/A'),
      _buildInfoRow('Password', '••••••••••••'),
      _buildInfoRow('Pin Code', '••••••••••••'),
    ]);
  }

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: maincolor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: maincolor, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: maincolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }

  String _formatGender(String? gender) {
    if (gender == null) return 'N/A';
    switch (gender.toUpperCase()) {
      case 'MALE':
        return 'Male';
      case 'FEMALE':
        return 'Female';
      default:
        return gender;
    }
  }

  String _translateMaterialStatus(String? status) {
    if (status == null) return 'N/A';
    switch (status.toLowerCase()) {
      case 'single':
        return 'Single';
      case 'married':
        return 'Married';
      case 'divorced':
        return 'Divorced';
      case 'widowed':
        return 'Widowed';
      default:
        return status;
    }
  }
}
