import 'package:bankemployers/features/home/view/widgets/employer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankemployers/features/home/view/viewmodel/cubits/employer_cubit/cubit/employers_cubit.dart';

class EmployersSettins extends StatelessWidget {
  final String employerId;

  const EmployersSettins({super.key, required this.employerId});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey[400]),
      onSelected: (value) async {
        final navigator = Navigator.of(context);
        final cubit = context.read<EmployersCubit>();

        switch (value) {
          case 'delete':
            cubit.deleteEmployer(employerId);
            break;

          case 'view':
            await cubit.getEmployerById(employerId);

            if (cubit.state is EmployersLoaded) {
              final employer = (cubit.state as EmployersLoaded).employers.first;
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => EmployerDetailsPage(employer: employer),
                ),
              );
            }
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
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
