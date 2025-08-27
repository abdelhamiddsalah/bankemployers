import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/empleyees/view/viewmodel/upload_cubit/upload_cubit.dart';
import 'package:bankemployers/features/empleyees/view/widgets/file_upload_section.dart';
import 'package:bankemployers/features/empleyees/view/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPanel extends StatelessWidget {
  const FormPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadCubit>(), // UploadCubit(),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              FileUploadSection(),
              const SizedBox(height: 40),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
