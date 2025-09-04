import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/view/widgets/all_file_info.dart';
import 'package:bankemployers/features/admin/view/widgets/copun_section.dart';
import 'package:bankemployers/features/admin/view/widgets/details_header.dart';
import 'package:bankemployers/features/admin/view/widgets/empty_selection.dart';
import 'package:bankemployers/features/admin/view/widgets/salary_section.dart';
import 'package:bankemployers/features/admin/view/widgets/status_section.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CVDetails extends StatelessWidget {
  const CVDetails({super.key, required this.cv});

  final AllCvSModel? cv;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: cv == null
          ? EmptySelection()
          : SingleChildScrollView(
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
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri uri = Uri.parse(cv!.file);
                        if (!await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch $cv!.file');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'view Cv',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  //     _buildCouponSection(cv),
                ],
              ),
            ),
    );
  }
}
