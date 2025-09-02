import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees/view/viewmodel/all_user_cubit/alluser_cubit.dart';
import 'package:bankemployers/features/empleyees/view/widgets/main_content_all_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersDashboard extends StatefulWidget {
  const UsersDashboard({super.key});

  @override
  _UsersDashboardState createState() => _UsersDashboardState();
}

class _UsersDashboardState extends State<UsersDashboard> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          'Bank Users Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: maincolor),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance, size: 50, color: maincolor),
                      SizedBox(height: 10),
                      Text(
                        'Bank Management',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: maincolor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildSidebarItem(Icons.account_circle, 'Users', true),
                      _buildSidebarItem(Icons.credit_card, 'Accounts', false),
                      _buildSidebarItem(
                        Icons.swap_horiz,
                        'Transactions',
                        false,
                      ),
                      _buildSidebarItem(Icons.analytics, 'Reports', false),
                      _buildSidebarItem(Icons.settings, 'Settings', false),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          BlocProvider(
            create: (context) => sl<AlluserCubit>(),
            child: MainContentAllUsers(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? maincolor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? maincolor : Colors.grey[600]),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? maincolor : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }

}
