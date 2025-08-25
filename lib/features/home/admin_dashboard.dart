import 'package:bankemployers/features/home/widgets/admin_dashboard_appbar.dart';
import 'package:bankemployers/features/home/widgets/liststate_card_employees_in_card.dart';
import 'package:bankemployers/features/home/widgets/search_and_sort.dart';
import 'package:bankemployers/features/home/widgets/section_employee.dart';
import 'package:flutter/material.dart';


class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          AdminDashboardAppBar(context: context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListStateCardEmployeesInCard(),
                SearchAndSort(),
                SectionEmployee(),
              ],
            ),
          ),
        ],
      ),
  
    );
  }
}






