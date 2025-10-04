
import 'package:bankemployers/features/employers_profile/view/widgets/edit_profile.dart';
import 'package:bankemployers/features/employers_profile/view/widgets/logout_profile.dart';
import 'package:flutter/material.dart';

class HeaderInProfile extends StatelessWidget {
  const HeaderInProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Company Profile',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
           EditProfile(),
            const SizedBox(width: 16),         
           LogoutProfile(),
          ],
        ),
      ],
    );
  }
}
