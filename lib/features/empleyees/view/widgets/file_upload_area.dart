import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees/view/viewmodel/upload_cubit/upload_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploadArea extends StatelessWidget {
  const FileUploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadState>(
      listener: (context, state) {
        if (state is FileSavedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File saved: ${state.path}')),
          );
        } else if (state is FilePickFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16),
          color: Colors.green.withOpacity(0.05),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child:  Icon(Icons.cloud_upload, color: maincolor, size: 40),
            ),
            const SizedBox(height: 20),
          Text(
            state is FileSavedSuccess
                ? state.path.split('/').last
                : 'Drop your CV here or click to browse',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
            const SizedBox(height: 8),
            Text(
              'Supported formats: PDF, DOC, DOCX (Max 10MB)',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            state is FilePickLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: () {
                      context.read<UploadCubit>().pickAndSaveFile();
                    },
                    icon: const Icon(Icons.folder_open, color: Colors.white),
                    label: const Text(
                      'Browse Files',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
