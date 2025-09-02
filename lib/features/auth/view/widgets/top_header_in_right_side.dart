import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/view/widgets/employers_sinin_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopHeaderInRightSide extends StatelessWidget {
  const TopHeaderInRightSide({super.key, required int currentStep})
    : _currentStep = currentStep;

  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                'Step ${_currentStep + 1} of 3',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => sl<EmployerCubit>(),
                  child: EmployersSininViewBody(),
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, color: maincolor, size: 18),
                SizedBox(width: 4),
                Text(
                  'Back to Sign In',
                  style: TextStyle(
                    color: maincolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
