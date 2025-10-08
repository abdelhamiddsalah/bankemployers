
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/viewmodel/cvs/cubit/cvs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({super.key, required this.cvs});

  final List<AllCvSModel> cvs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.description, color: Colors.white, size: 30),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All CVs',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Total: ${cvs.length} CVs',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<CvsCubit>().getAllCvs();
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
