import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/employers_auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/employers_auth/view/widgets/employer_sinup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployerSinupView extends StatelessWidget {
  const EmployerSinupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<EmployerCubit>(),
        child: EmployeeSignupScreen(),
      ),
    );
  }
}
