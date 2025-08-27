import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class ColumnInSigninSupport extends StatelessWidget {
  const ColumnInSigninSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Need help?',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          TextButton(
            onPressed: () {
              // Handle support
            },
            child: Text(
              'Contact IT Support',
              style: TextStyle(
                color: maincolor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
