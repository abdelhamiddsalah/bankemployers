import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:flutter/material.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({super.key, required this.cv});
  final AllCvSModel cv;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: maincolor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.description, color: maincolor, size: 32),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cv.file,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'ID: ${cv.id}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
