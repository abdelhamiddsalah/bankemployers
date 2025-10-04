import 'package:bankemployers/features/empleyees_dashboard/view/widgets/approved_widget.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/widgets/rejected_widget.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/cvs/view/viewmodel/cubits/upload_cubit/upload_cubit.dart';
import 'package:bankemployers/features/cvs/view/widgets/file_upload_section.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/widgets/submit_button.dart';

class FormPanel extends StatelessWidget {
  const FormPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadCubit>()..getCvDetails(),
      child: Container(
        color: Colors.white,
        child: BlocBuilder<UploadCubit, UploadState>(
          builder: (context, state) {
            if (state is UploadLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CvDetailsLoaded) {
              final cv = state.cv;
              if (cv.resultCv.toLowerCase() == 'approved') {
                return ApprovedWidget(cv: cv);
              } else if (cv.resultCv.toLowerCase() == 'rejected') {
                return const RejectedWidget();
              } else {
                return const WaitingWidget();
              }
            }
            if (state is UploadFailure) {
              return Center(child: Text(state.error));
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 32),
                  FileUploadSection(),
                  SizedBox(height: 40),
                  SubmitButton(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


