import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/view/widgets/file_info.dart';
import 'package:bankemployers/features/admin/view/widgets/row_info.dart';
import 'package:flutter/material.dart';

class AllFileInfoSection extends StatelessWidget {
  const AllFileInfoSection({super.key, required this.cv});

  final AllCvSModel cv;

  @override
  Widget build(BuildContext context) {
    return FileInfoSection(
      title: 'File Information',
      icon: Icons.info_outline,
      child: Column(
        children: [
          InfoRow(label: 'File Name', value: cv.file),
          InfoRow(label: 'Full Path', value: cv.file),
          InfoRow(label: 'ID', value: cv.id.toString()),
        ],
      ),
    );
  }
}

