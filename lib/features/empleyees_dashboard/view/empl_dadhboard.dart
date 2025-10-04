import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/core/routing/routes.dart';
import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/viewmodel/all_user_cubit/alluser_cubit.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/widgets/main_content_all_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UsersDashboard extends StatefulWidget {
  const UsersDashboard({super.key});

  @override
  _UsersDashboardState createState() => _UsersDashboardState();
}

class _UsersDashboardState extends State<UsersDashboard> {
  String selectedPage = 'Users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          'Bank Management Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: GestureDetector(
                onTap: () => {
                  context.go(Routes.employersProfile),
                },
                child: Icon(Icons.person, color: maincolor)),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // 🟦 Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance, size: 50, color: maincolor),
                      const SizedBox(height: 10),
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
                      _buildSidebarItem(Icons.account_circle, 'Users'),
                      _buildSidebarItem(Icons.credit_card, 'Accounts'),
                      _buildSidebarItem(Icons.swap_horiz, 'Transactions'),
                      _buildSidebarItem(Icons.analytics, 'Reports'),
                      _buildSidebarItem(Icons.settings, 'Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🟩 Main Content (Switch according to selectedPage)
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  // Sidebar Item Widget
  Widget _buildSidebarItem(IconData icon, String title) {
    bool isSelected = selectedPage == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPage = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
        ),
      ),
    );
  }

  // Main Content switching
  Widget _buildMainContent() {
    switch (selectedPage) {
      case 'Users':
        return BlocProvider(
          create: (context) => sl<AlluserCubit>(),
          child: const MainContentAllUsers(),
        );
      case 'Accounts':
        // مثال: استخدم GoRouter أو اعمل صفحة مخصصة
        return Center(child: Text('Accounts Page Coming Soon...'));
      case 'Transactions':
        return Center(child: Text('Transactions Page Coming Soon...'));
      case 'Reports':
        return Center(child: Text('Reports Page Coming Soon...'));
      case 'Settings':
        return Center(child: Text('Settings Page Coming Soon...'));
      default:
        return Center(child: Text('Select a page'));
    }
  }
}
