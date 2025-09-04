
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/view/widgets/all_file_info.dart';
import 'package:bankemployers/features/admin/view/widgets/copun_section.dart';
import 'package:bankemployers/features/admin/view/widgets/details_header.dart';
import 'package:bankemployers/features/admin/view/widgets/empty_selection.dart';
import 'package:bankemployers/features/admin/view/widgets/salary_section.dart';
import 'package:bankemployers/features/admin/view/widgets/status_section.dart';
import 'package:flutter/material.dart';

class CVDetails extends StatelessWidget {
  const CVDetails({super.key, required this.cv});

  final AllCvSModel? cv;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: cv == null ? EmptySelection() :  SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsHeader(cv: cv!),
            SizedBox(height: 32),
            AllFileInfoSection(cv: cv!),
            SizedBox(height: 32),
            StatusSection(cv: cv!),
            SizedBox(height: 32),
            SalarySection(cv: cv!),
            SizedBox(height: 32),
            CopunSection(cv: cv!),

            //     _buildCouponSection(cv),
          ],
        ),
      ),
    );
  }
}
