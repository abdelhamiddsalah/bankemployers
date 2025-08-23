// widgets/success_dialog.dart
import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onGoToSignIn;

  const SuccessDialog({
    super.key,
    required this.onGoToSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.check_circle, 
            color: Colors.green, 
            size: 28,
          ),
          SizedBox(width: 12),
          Text('Registration Successful!'),
        ],
      ),
      content: Text(
        'Your employee account has been created successfully. '
        'You can now sign in with your credentials.',
      ),
      actions: [
        ElevatedButton(
          onPressed: onGoToSignIn,
          style: ElevatedButton.styleFrom(
            backgroundColor: maincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Go to Sign In', 
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}