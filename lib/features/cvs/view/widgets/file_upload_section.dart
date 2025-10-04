import 'package:bankemployers/features/cvs/view/widgets/file_upload_area.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/widgets/section_title.dart';
import 'package:flutter/material.dart';

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Upload CV', icon: Icons.upload_file),
        const SizedBox(height: 20),
        FileUploadArea(),
      ],
    );
  }
}

