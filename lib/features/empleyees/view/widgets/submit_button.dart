import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees/view/viewmodel/upload_cubit/upload_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadState>(
      listener: (context, state) {
        if (state is UploadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.responseMessage)),
          );
        } else if (state is UploadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Upload failed: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is UploadLoading;
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<UploadCubit>().uploadSavedFile(
                         
                        );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Submit Application',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
