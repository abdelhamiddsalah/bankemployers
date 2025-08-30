import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankemployers/features/home/view/viewmodel/cubits/employer_cubit/cubit/employers_cubit.dart';

class EmployersSettins extends StatelessWidget {
  final String employerId;

  const EmployersSettins({
    super.key,
    required this.employerId,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey[400]),
      onSelected: (value) {
        switch (value) {
          case 'delete':
            context.read<EmployersCubit>().deleteEmployer(employerId);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'view',
          child: Row(
            children: [
              Icon(Icons.visibility, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text('View Details'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'message',
          child: Row(
            children: [
              Icon(Icons.message, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('Send Message'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
