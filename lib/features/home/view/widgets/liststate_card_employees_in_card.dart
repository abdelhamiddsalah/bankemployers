import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/routing/routes.dart';
import 'package:bankemployers/features/admin/data/repos/admin_repo.dart';
import 'package:bankemployers/features/admin/viewmodel/cvs/cubit/cvs_cubit.dart';
import 'package:bankemployers/features/empleyees_dashboard/data/repo/employes_repo.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/viewmodel/all_user_cubit/alluser_cubit.dart';
import 'package:bankemployers/features/home/data/repos/employers_repo.dart';
import 'package:bankemployers/features/home/view/viewmodel/cubits/employer_cubit/cubit/employers_cubit.dart';
import 'package:bankemployers/features/home/view/widgets/state_card_emplyee_in_admin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ListStateCardEmployeesInCard extends StatelessWidget {
  const ListStateCardEmployeesInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CvsCubit(AdminRepo(dioConsumer: DioConsumer(dio: Dio())))
                ..getAllCvs(),
        ),
        BlocProvider(
          create: (context) => EmployersCubit(
            employersRepo: EmployersRepo(dioConsumer: DioConsumer(dio: Dio())),
          )..getAllEmployers(),
        ),
        BlocProvider(
          create: (context) =>
              AlluserCubit(EmployesRepo(dioConsumer: DioConsumer(dio: Dio())))
                ..getAllEmployers(),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BlocBuilder<CvsCubit, CvsState>(
                builder: (context, state) {
                  return StateCardEmplyeeInAdmin(
                    title: 'Total CVs',
                    subtitle: 'Uploaded CVs',
                    value: state is CvsSuccess
                        ? state.allCvSModel.length.toString()
                        : '0',
                    icon: Icons.description_outlined,
                    color: Colors.blue,
                    onTap: () {
                      GoRouter.of(context).push(Routes.allcvs);
                    },
                  );
                },
              ),
              SizedBox(width: 12),
              BlocBuilder<EmployersCubit, EmployersState>(
                builder: (context, state) {
                  return StateCardEmplyeeInAdmin(
                    title: 'Total Employees',
                    subtitle: 'Active Employees',
                    value: state is EmployersLoaded
                        ? state.employers.length.toString()
                        : '0',
                    icon: Icons.work_outline,
                    color: Colors.green,
                    onTap: () {
                      GoRouter.of(context).push(Routes.employees);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
