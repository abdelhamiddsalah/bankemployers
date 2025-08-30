import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/home/view/viewmodel/cubits/employer_cubit/cubit/employers_cubit.dart';
import 'package:bankemployers/features/home/view/widgets/employee_list_card.dart';
import 'package:bankemployers/features/home/view/widgets/search_and_sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// SOLUTION 1: Using Expanded (Recommended)
class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Employees', style: TextStyle(color: Colors.white)),
        backgroundColor: maincolor,
      ),
      body: BlocBuilder<EmployersCubit, EmployersState>(
        builder: (context, state) {
          if (state is EmployersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EmployersLoaded) {
            final employers = state.employers;
            return Column(
              children: [
                SizedBox(height: 16),
                SearchAndSort(),
                Expanded( // This gives the ListView bounded height
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: employers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EmployeeListCard(index: index),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is EmployersError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No Data Found'));
          }
        },
      ),
    );
  }
}