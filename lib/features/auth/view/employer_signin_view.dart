import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/view/widgets/employers_sinin_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployerSigninView extends StatelessWidget {
  const EmployerSigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<EmployerCubit>(),
        child: EmployersSininViewBody(),
      ),
    );
  }
}
