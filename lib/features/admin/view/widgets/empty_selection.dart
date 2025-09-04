import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class EmptySelection extends StatelessWidget {
  const EmptySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: maincolor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(Icons.touch_app, color: maincolor, size: 60),
          ),
          SizedBox(height: 24),
          Text(
            'Select a CV to view details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Click on any CV from the list to view and edit its details',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
