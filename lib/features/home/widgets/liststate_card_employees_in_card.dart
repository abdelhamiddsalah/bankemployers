import 'package:bankemployers/features/home/widgets/state_card_emplyee_in_admin.dart';
import 'package:flutter/material.dart';

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
              title: 'Total Employees',
              subtitle: '150',
              value: '150',
              icon: Icons.group,
              color: Colors.blue,
            ),
            SizedBox(width: 12),

            StateCardEmplyeeInAdmin(
              title: 'Total Employees',
              subtitle: '150',
              value: '150',
              icon: Icons.group,
              color: Colors.blue,
            ),
            SizedBox(width: 12),
            StateCardEmplyeeInAdmin(
              title: 'Total Employees',
              subtitle: '150',
              value: '150',
              icon: Icons.group,
              color: Colors.blue,
            ),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
