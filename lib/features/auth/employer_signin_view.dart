import 'package:bankemployers/features/auth/cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/widgets/employers_sinin_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployerSigninView extends StatelessWidget {
  const EmployerSigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EmployerCubit(),
        child: EmployersSininViewBody(),
      ),
    );
  }
}
