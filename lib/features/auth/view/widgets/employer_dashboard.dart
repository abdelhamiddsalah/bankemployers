import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/auth/view/widgets/employers_sinin_view_body.dart';
import 'package:bankemployers/features/auth/view/widgets/info_card_in_signin.dart';
import 'package:flutter/material.dart';

class EmployeeDashboard extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDashboard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Dashboard'),
        backgroundColor: maincolor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EmployersSininViewBody()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [maincolor, Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${employee['firstName']} ${employee['lastName']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${employee['jobTitle']} - ${employee['department']}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            
                  Text(
              'Employee Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                children: [
                  InfoCardInSignin(title: 'Employee ID', value: employee['employeeID'], icon: Icons.badge),
                  InfoCardInSignin(title: 'Email', value: employee['email'], icon: Icons.email),
                  InfoCardInSignin(title: 'Phone', value: employee['phoneNumber'], icon: Icons.phone),
                  InfoCardInSignin(title: 'Branch', value: employee['workBranch'], icon: Icons.location_on),
                  InfoCardInSignin(title: 'Hire Date', value: employee['dateOfHiring'], icon: Icons.calendar_today),
                  InfoCardInSignin(title: 'Status', value: employee['maritalStatus'], icon: Icons.person),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }  
}