import 'package:bankemployers/features/home/widgets/employees_pagge.dart';
import 'package:bankemployers/features/home/widgets/state_card_emplyee_in_admin.dart';
import 'package:flutter/material.dart';
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
                  MaterialPageRoute(builder: (_) => EmployeesPage()),
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
            // باقي الـ Cards بدون Navigation أو تضيفهم لاحقاً
          ],
        ),
      ),
    );
  }
}
