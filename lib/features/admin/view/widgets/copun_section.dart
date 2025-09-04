
import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/view/widgets/file_info.dart';
import 'package:bankemployers/features/admin/viewmodel/cvs/cubit/cvs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CopunSection extends StatelessWidget {
  const CopunSection({super.key, required this.cv});
  final AllCvSModel cv;
  @override
  Widget build(BuildContext context) {
    return FileInfoSection(
      title: 'Proposed Copoun',
      icon: Icons.attach_money,
      child: Column(
        children: [
          if (cv.copoun.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_money, color: Colors.green, size: 24),
                  SizedBox(width: 12),
                  Text(
                    '${cv.copoun} ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.money_off, color: Colors.grey, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'No copoun specified',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          cv.copoun.isNotEmpty 
              ? Container()
              : Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: context.read<CvsCubit>().copounController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'copoun',
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: maincolor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: maincolor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CvsCubit>().putCvStatus(
                            cv.id,
                            cv.resultCv,
                            cv.salary,
                      context.read<CvsCubit>().copounController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

