import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';
import 'list_view_employee_card.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Employees',style: TextStyle(color: Colors.white),),backgroundColor: maincolor,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListViewEmployeeCard(), 
        ),
      ),
    );
  }
}
