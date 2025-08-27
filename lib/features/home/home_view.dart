import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

const Color primaryColor = Color(0xFF6366F1);
const Color secondaryColor = Color(0xFF8B5CF6);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color cardColor = Colors.white;




class CVUploadPage extends StatefulWidget {
  const CVUploadPage({Key? key}) : super(key: key);

  @override
  _CVUploadPageState createState() => _CVUploadPageState();
}

class _CVUploadPageState extends State<CVUploadPage>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          // Left Panel - Hero Section
          Expanded(
            flex: 5,
            child: _buildHeroPanel(),
          ),
          // Right Panel - Form Section
          Expanded(
            flex: 7,
            child: _buildFormPanel(),
          ),
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
          colors: [
            primaryColor,
            secondaryColor,
          ],
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
          .map((feature) => Padding(
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
              ))
          .toList(),
    );
  }

  Widget _buildFormPanel() {
    return Container(
      color: cardColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            const SizedBox(height: 32),
            _buildFileUploadSection(),
            const SizedBox(height: 40),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }



  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Upload CV', Icons.upload_file),
        const SizedBox(height: 20),
        _buildFileUploadArea(),
      ],
    );
  }

  Widget _buildFileUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(
          color:  Colors.green,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16),
        color:
             Colors.green.withOpacity(0.05)
           
      ),
      child: Column(
        children: [
      
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.cloud_upload,
                color: primaryColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Drop your CV here or click to browse',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Supported formats: PDF, DOC, DOCX (Max 10MB)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.folder_open, color: Colors.white),
              label: const Text('Browse Files', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          
             
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Submit Application',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

   Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  
  

// Timer utility (since dart:async Timer is not available by default)

}