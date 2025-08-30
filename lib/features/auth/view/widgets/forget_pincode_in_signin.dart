import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class ForgetPinCodeInSignin extends StatelessWidget {
  const ForgetPinCodeInSignin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // Handle forgot password
          },
          child: Text(
            'Forgot PinCode?',
            style: TextStyle(
              color: maincolor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
