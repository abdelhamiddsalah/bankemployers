import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/features/admin/data/repos/admin_repo.dart';
import 'package:bankemployers/features/admin/view/widgets/admin_view_body.dart';
import 'package:bankemployers/features/admin/viewmodel/cubits/admin/admin_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AdminCubit(adminRepo: AdminRepo(dioConsumer: DioConsumer(dio: Dio()))),
        child: AdminViewBody(),
      ),
    );
  }
}
