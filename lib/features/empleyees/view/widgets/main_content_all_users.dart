import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees/view/viewmodel/cubit/alluser_cubit.dart';
import 'package:bankemployers/features/empleyees/view/widgets/stat_card.dart';
import 'package:bankemployers/features/empleyees/view/widgets/user_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContentAllUsers extends StatelessWidget {
  const MainContentAllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlluserCubit, AlluserState>(
      builder: (context, state) {
        if (state is AllusersLoaded) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Users Management',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Manage and monitor all bank customers',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: 'Total users',
                          value: state.employers.length.toString(),
                          icon: Icons.person,
                          color: maincolor,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: StatCard(
                          title: 'Total balence',
                          value:
                              '${state.employers.fold(0.0, (sum, user) => sum + (user.account?.balance ?? 0.0)).toStringAsFixed(2)} EGP',
                          icon: Icons.attach_money,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Filters and Search (ثابتة مش Expanded)
                  SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Search users by name, email, phone, or account number...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: maincolor),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Users Table (يملى الشاشة كلها)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Table Header (ثابت)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[200]!),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Customer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Type',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Balance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Table Content (Scrollable)
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.employers.length,
                              itemBuilder: (context, index) {
                                final user = state.employers[index];
                                return UserRow(user: user);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is AlluserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
