import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class BankUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String accountNumber;
  final String accountType;
  final double balance;
  final String status;
  final DateTime joinDate;
  final String address;

  BankUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.status,
    required this.joinDate,
    required this.address,
  });
}

class UsersDashboard extends StatefulWidget {
  const UsersDashboard({super.key});

  @override
  _UsersDashboardState createState() => _UsersDashboardState();
}

class _UsersDashboardState extends State<UsersDashboard> {
  String selectedFilter = 'All';

  
  List<BankUser> users = [
    BankUser(
      id: 'USR001',
      name: 'Mohamed Ahmed',
      email: 'mohamed.ahmed@email.com',
      phone: '+20 10 1234 5678',
      accountNumber: '1234567890123456',
      accountType: 'Savings',
      balance: 15000.50,
      status: 'Active',
      joinDate: DateTime(2023, 1, 15),
      address: 'Cairo, Egypt',
    ),
    BankUser(
      id: 'USR002',
      name: 'Nour Hassan',
      email: 'nour.hassan@email.com',
      phone: '+20 11 9876 5432',
      accountNumber: '2345678901234567',
      accountType: 'Current',
      balance: 25000.75,
      status: 'Active',
      joinDate: DateTime(2023, 3, 22),
      address: 'Alexandria, Egypt',
    ),
    BankUser(
      id: 'USR003',
      name: 'Youssef Mohamed',
      email: 'youssef.mohamed@email.com',
      phone: '+20 12 5555 6666',
      accountNumber: '3456789012345678',
      accountType: 'Business',
      balance: 45000.00,
      status: 'Active',
      joinDate: DateTime(2022, 11, 8),
      address: 'Giza, Egypt',
    ),
  ];

  double get totalBalance => users.fold(0, (sum, user) => sum + user.balance);
  int get activeUsers => users.where((user) => user.status == 'Active').length;
  int get suspendedUsers => users.where((user) => user.status == 'Suspended').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text('Bank Users Dashboard', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
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
                      _buildSidebarItem(Icons.swap_horiz, 'Transactions', false),
                      _buildSidebarItem(Icons.analytics, 'Reports', false),
                      _buildSidebarItem(Icons.settings, 'Settings', false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24),
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
                      ElevatedButton.icon(
                        onPressed: () => _showAddUserDialog(context),
                        icon: Icon(Icons.person_add),
                        label: Text('Add User'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Stats Cards
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Total Users', '${users.length}', Icons.people, maincolor)),
                      SizedBox(width: 20),
                      Expanded(child: _buildStatCard('Total Balance', '${totalBalance.toStringAsFixed(2)} EGP', Icons.account_balance_wallet, Colors.orange)),
                    ],
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Filters and Search
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search users by name, email, phone, or account number...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: maincolor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          value: selectedFilter,
                          items: ['All', 'Savings', 'Current', 'Business', 'Premium']
                              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedFilter = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Users Table
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
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 2, child: Text('Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                Expanded(child: Text('Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                Expanded(child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                Expanded(child: Text('Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                SizedBox(width: 120, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                               
                                return _buildUserRow( 
                                  BankUser(
                                    name: 'User ${index + 1}',
                                    email: 'user${index + 1}@example.com',
                                    accountNumber: '1234567890',
                                    phone: '555-010${index + 1}',
                                    accountType: 'Savings',
                                    balance: 1000.0,
                                    status: 'Active',
                                    id: '',
                                    joinDate: DateTime.now(),
                                    address: '',
                                  )
                                );
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
        leading: Icon(
          icon,
          color: isSelected ? maincolor : Colors.grey[600],
        ),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: title.contains('Balance') ? 16 : 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow(BankUser user) {
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: maincolor.withOpacity(0.1),
                  child: Text(
                    user.name.split(' ').map((n) => n[0]).join(''),
                    style: TextStyle(color: maincolor, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      user.phone,
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 '12',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Text(
                  'ID: ${user.id}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: maincolor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user.accountType,
                style: TextStyle(color: maincolor, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${user.balance.toStringAsFixed(2)} EGP',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.green[700]),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: user.status == 'Active' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user.status,
                style: TextStyle(
                  color: user.status == 'Active' ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _showUserDetails(context, user),
                  icon: Icon(Icons.visibility, color: maincolor, size: 18),
                  tooltip: 'View Details',
                ),
                IconButton(
                  onPressed: () => _showEditUserDialog(context, user),
                  icon: Icon(Icons.edit, color: Colors.blue, size: 18),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () => _showAccountActions(context, user),
                  icon: Icon(Icons.more_vert, color: Colors.grey[600], size: 18),
                  tooltip: 'More Actions',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showAddUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final balanceController = TextEditingController(text: '0.00');
    String selectedAccountType = 'Savings';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Add New User'),
              content: Container(
                width: 450,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Account Type',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedAccountType,
                        items: ['Savings', 'Current', 'Business', 'Premium', 'Student']
                            .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                            .toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedAccountType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: balanceController,
                        decoration: InputDecoration(
                          labelText: 'Initial Balance (EGP)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && 
                        emailController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      setState(() {
                        String accountNumber = '${DateTime.now().millisecondsSinceEpoch}'.substring(3);
                        users.add(BankUser(
                          id: 'USR${(users.length + 1).toString().padLeft(3, '0')}',
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          accountNumber: accountNumber,
                          accountType: selectedAccountType,
                          balance: double.tryParse(balanceController.text) ?? 0.0,
                          status: 'Active',
                          joinDate: DateTime.now(),
                          address: addressController.text,
                        ));
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User added successfully!')),
                      );
                    }
                  },
                  child: Text('Add User'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showUserDetails(BuildContext context, BankUser user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: maincolor.withOpacity(0.1),
                child: Text(
                  user.name.split(' ').map((n) => n[0]).join(''),
                  style: TextStyle(color: maincolor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 12),
              Text('User Details'),
            ],
          ),
          content: Container(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('User ID:', user.id),
                  _buildDetailRow('Full Name:', user.name),
                  _buildDetailRow('Email:', user.email),
                  _buildDetailRow('Phone:', user.phone),
                  _buildDetailRow('Address:', user.address),
                  _buildDetailRow('Account Number:', user.accountNumber),
                  _buildDetailRow('Account Type:', user.accountType),
                  _buildDetailRow('Balance:', '${user.balance.toStringAsFixed(2)} EGP'),
                  _buildDetailRow('Status:', user.status),
                  _buildDetailRow('Join Date:', '${user.joinDate.day}/${user.joinDate.month}/${user.joinDate.year}'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditUserDialog(context, user);
              },
              child: Text('Edit User'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, BankUser user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);
    final addressController = TextEditingController(text: user.address);
    String selectedAccountType = user.accountType;
    String selectedStatus = user.status;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Edit User'),
              content: Container(
                width: 450,
                height: 450,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Account Type',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedAccountType,
                        items: ['Savings', 'Current', 'Business', 'Premium', 'Student']
                            .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                            .toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedAccountType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedStatus,
                        items: ['Active', 'Suspended']
                            .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                            .toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedStatus = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final index = users.indexWhere((u) => u.id == user.id);
                      if (index != -1) {
                        users[index] = BankUser(
                          id: user.id,
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          accountNumber: user.accountNumber,
                          accountType: selectedAccountType,
                          balance: user.balance,
                          status: selectedStatus,
                          joinDate: user.joinDate,
                          address: addressController.text,
                        );
                      }
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User updated successfully!')),
                    );
                  },
                  child: Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAccountActions(BuildContext context, BankUser user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Actions - ${user.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildActionTile(
                icon: Icons.account_balance_wallet,
                title: 'Manage Balance',
                subtitle: 'Add or deduct balance',
                onTap: () {
                  Navigator.pop(context);
                  _showBalanceDialog(context, user);
                },
              ),
              _buildActionTile(
                icon: user.status == 'Active' ? Icons.block : Icons.check_circle,
                title: user.status == 'Active' ? 'Suspend Account' : 'Activate Account',
                subtitle: user.status == 'Active' ? 'Temporarily suspend user' : 'Reactivate user account',
                onTap: () {
                  Navigator.pop(context);
                  _toggleUserStatus(user);
                },
              ),
              _buildActionTile(
                icon: Icons.history,
                title: 'Transaction History',
                subtitle: 'View account transactions',
                onTap: () {
                  Navigator.pop(context);
                  _showTransactionHistory(context, user);
                },
              ),
              _buildActionTile(
                icon: Icons.security,
                title: 'Security Settings',
                subtitle: 'Manage account security',
                onTap: () {
                  Navigator.pop(context);
                  _showSecuritySettings(context, user);
                },
              ),
              _buildActionTile(
                icon: Icons.delete_forever,
                title: 'Delete Account',
                subtitle: 'Permanently delete user account',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, user);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: (color ?? maincolor).withOpacity(0.1),
        child: Icon(icon, color: color ?? maincolor),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showBalanceDialog(BuildContext context, BankUser user) {
    final amountController = TextEditingController();
    String operation = 'Add';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Manage Balance'),
              content: Container(
                width: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Current Balance: ${user.balance.toStringAsFixed(2)} EGP',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: maincolor),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Operation',
                        border: OutlineInputBorder(),
                      ),
                      value: operation,
                      items: ['Add', 'Deduct']
                          .map((op) => DropdownMenuItem(value: op, child: Text('$op Balance')))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          operation = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount (EGP)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double amount = double.tryParse(amountController.text) ?? 0;
                    if (amount > 0) {
                      setState(() {
                        final index = users.indexWhere((u) => u.id == user.id);
                        if (index != -1) {
                          double newBalance = operation == 'Add' 
                              ? user.balance + amount 
                              : user.balance - amount;
                          if (newBalance >= 0) {
                            users[index] = BankUser(
                              id: user.id,
                              name: user.name,
                              email: user.email,
                              phone: user.phone,
                              accountNumber: user.accountNumber,
                              accountType: user.accountType,
                              balance: newBalance,
                              status: user.status,
                              joinDate: user.joinDate,
                              address: user.address,
                            );
                          }
                        }
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Balance updated successfully!')),
                      );
                    }
                  },
                  child: Text('Update Balance'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _toggleUserStatus(BankUser user) {
    setState(() {
      final index = users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        users[index] = BankUser(
          id: user.id,
          name: user.name,
          email: user.email,
          phone: user.phone,
          accountNumber: user.accountNumber,
          accountType: user.accountType,
          balance: user.balance,
          status: user.status == 'Active' ? 'Suspended' : 'Active',
          joinDate: user.joinDate,
          address: user.address,
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User status updated successfully!')),
    );
  }

  void _showTransactionHistory(BuildContext context, BankUser user) {
    // Sample transaction data
    List<Map<String, dynamic>> transactions = [
      {'date': '2024/01/28', 'type': 'Deposit', 'amount': 1000.0, 'description': 'Salary'},
      {'date': '2024/01/25', 'type': 'Withdrawal', 'amount': 500.0, 'description': 'ATM Withdrawal'},
      {'date': '2024/01/20', 'type': 'Transfer', 'amount': 2000.0, 'description': 'Online Transfer'},
      {'date': '2024/01/15', 'type': 'Deposit', 'amount': 3000.0, 'description': 'Check Deposit'},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction History - ${user.name}'),
          content: Container(
            width: 500,
            height: 400,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: maincolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: maincolor),
                      SizedBox(width: 8),
                      Text('Current Balance: ${user.balance.toStringAsFixed(2)} EGP',
                           style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: transaction['type'] == 'Deposit' 
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          child: Icon(
                            transaction['type'] == 'Deposit' ? Icons.add : Icons.remove,
                            color: transaction['type'] == 'Deposit' ? Colors.green : Colors.red,
                          ),
                        ),
                        title: Text(transaction['description']),
                        subtitle: Text(transaction['date']),
                        trailing: Text(
                          '${transaction['type'] == 'Deposit' ? '+' : '-'}${transaction['amount'].toStringAsFixed(2)} EGP',
                          style: TextStyle(
                            color: transaction['type'] == 'Deposit' ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSecuritySettings(BuildContext context, BankUser user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Security Settings - ${user.name}'),
          content: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSecurityOption('Reset Password', Icons.lock_reset),
                _buildSecurityOption('Enable Two-Factor Auth', Icons.security),
                _buildSecurityOption('Block Card', Icons.credit_card_off),
                _buildSecurityOption('View Login History', Icons.history),
                _buildSecurityOption('Security Questions', Icons.quiz),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSecurityOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: maincolor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title action executed')),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, BankUser user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete User Account'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to delete this user account?'),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User: ${user.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Account: ${user.accountNumber}'),
                    Text('Balance: ${user.balance.toStringAsFixed(2)} EGP'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'This action cannot be undone. All user data and transaction history will be permanently deleted.',
                style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  users.removeWhere((u) => u.id == user.id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User account deleted successfully!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }
}