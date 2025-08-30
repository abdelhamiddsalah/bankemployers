import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/features/home/data/repos/employers_repo.dart';
import 'package:bankemployers/features/home/view/viewmodel/cubits/employer_cubit/cubit/employers_cubit.dart';
import 'package:bankemployers/features/home/view/widgets/employees_pagge.dart';
import 'package:bankemployers/features/home/view/widgets/state_card_emplyee_in_admin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'users_page.dart';
import 'cvs_page.dart';

class ListStateCardEmployeesInCard extends StatelessWidget {
  const ListStateCardEmployeesInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            StateCardEmplyeeInAdmin(
              title: 'Total CVs',
              subtitle: 'Uploaded CVs',
              value: '150',
              icon: Icons.description_outlined,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CVsPage()),
                );
              },
            ),
            SizedBox(width: 12),
            StateCardEmplyeeInAdmin(
              title: 'Total Employees',
              subtitle: 'Active Employees',
              value: '85',
              icon: Icons.work_outline,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => EmployersCubit(
                        employersRepo: EmployersRepo(dioConsumer: DioConsumer(dio: Dio())),
                      )..getAllEmployers(),
                      child: EmployeesPage(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 12),
            StateCardEmplyeeInAdmin(
              title: 'Total Users',
              subtitle: 'Registered Users',
              value: '230',
              icon: Icons.people_outline,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UsersPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
