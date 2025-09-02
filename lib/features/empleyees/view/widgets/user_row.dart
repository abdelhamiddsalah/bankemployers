import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees/data/models/user_in_employee.dart';
import 'package:bankemployers/features/empleyees/view/viewmodel/all_user_cubit/alluser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRow extends StatelessWidget {
  const UserRow({
    super.key,
    required this.user,
  });

  final UserInEmployee user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          // Customer Info
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: maincolor.withOpacity(0.1),
                  child: Text(
                    user.firstName.split(' ').map((n) => n[0]).join(''),
                    style: TextStyle(
                      color: maincolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      user.phoneNumber,
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Account Number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '12',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Text(
                  'ID: ${user.id}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
              ],
            ),
          ),

          // Account Type as Chip
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: maincolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user.account?.accountType ?? '',
                  style: TextStyle(
                    color: maincolor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          // Balance
          Expanded(
            child: Text(
              '${user.account?.balance ?? '0'} EGP',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
          ),
          // Actions
          SizedBox(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _showUserDetails(context, user);
                  },
                  icon: Icon(Icons.visibility, color: maincolor, size: 18),
                  tooltip: 'View Details',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () {
                    context.read<AlluserCubit>().deleteEmployer(user.id.toString());
                  },
                  icon: Icon(Icons.delete, color: Colors.red[600], size: 18),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(BuildContext context, UserInEmployee user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: maincolor.withOpacity(0.1),
                child: Text(
                  user.firstName.split(' ').map((n) => n[0]).join(''),
                  style: TextStyle(
                    color: maincolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text('User Details'),
            ],
          ),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('User ID:', user.id.toString()),
                  _buildDetailRow('Full Name:', '${user.firstName} ${user.lastName}'),
                  _buildDetailRow('Email:', user.email),
                  _buildDetailRow('Phone:', user.phoneNumber),
                  _buildDetailRow('Address:', user.address.city),
                  _buildDetailRow('Account Number:', user.account?.accountNumber ?? ''),
                  _buildDetailRow('Account Type:', user.account?.accountType ?? ''),
                  _buildDetailRow(
                    'Balance:',
                    '${user.account?.balance ?? '0'} EGP',
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Edit User'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[800])),
          ),
        ],
      ),
    );
  }
}
