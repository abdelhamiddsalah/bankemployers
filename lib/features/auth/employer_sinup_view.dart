import 'package:bankemployers/features/auth/cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/widgets/employer_sinup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployerSinupView extends StatelessWidget {
  const EmployerSinupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EmployerCubit(),
        child: EmployeeSignupScreen(),
      ),
    );
  }
}
