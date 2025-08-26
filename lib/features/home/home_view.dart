import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ------------------- Constants & Theme -------------------

const Color maincolor = Color(0xFF6366F1);
const Color successColor = Color(0xFF10B981);
const Color warningColor = Color(0xFFF59E0B);
const Color dangerColor = Color(0xFFEF4444);
const Color backgroundColor = Color(0xFFF8FAFC);
const Color cardColor = Colors.white;

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: maincolor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: cardColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}

// ------------------- Enhanced Data Models -------------------

class Employee {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String position;
  double balance;
  final DateTime joinDate;
  final String avatar;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.position,
    required this.balance,
    required this.joinDate,
    this.avatar = '',
  });

  String get initials => name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();
}

enum RequestType { deposit, withdrawal, loan, advance }
enum RequestStatus { pending, approved, rejected, processing }

class Request {
  final String id;
  final String employeeId;
  final RequestType type;
  final double amount;
  RequestStatus status;
  final DateTime date;
  final String? notes;
  final String? adminNotes;
  final DateTime? processedDate;

  Request({
    required this.id,
    required this.employeeId,
    required this.type,
    required this.amount,
    this.status = RequestStatus.pending,
    required this.date,
    this.notes,
    this.adminNotes,
    this.processedDate,
  });

  String get typeString {
    switch (type) {
      case RequestType.deposit:
        return 'إيداع';
      case RequestType.withdrawal:
        return 'سحب';
      case RequestType.loan:
        return 'قرض';
      case RequestType.advance:
        return 'سلفة';
    }
  }

  String get statusString {
    switch (status) {
      case RequestStatus.pending:
        return 'معلق';
      case RequestStatus.approved:
        return 'موافق عليه';
      case RequestStatus.rejected:
        return 'مرفوض';
      case RequestStatus.processing:
        return 'قيد المعالجة';
    }
  }

  Color get statusColor {
    switch (status) {
      case RequestStatus.pending:
        return warningColor;
      case RequestStatus.approved:
        return successColor;
      case RequestStatus.rejected:
        return dangerColor;
      case RequestStatus.processing:
        return Colors.blue;
    }
  }

  IconData get typeIcon {
    switch (type) {
      case RequestType.deposit:
        return Icons.arrow_downward;
      case RequestType.withdrawal:
        return Icons.arrow_upward;
      case RequestType.loan:
        return Icons.account_balance;
      case RequestType.advance:
        return Icons.flash_on;
    }
  }

  Color get typeColor {
    switch (type) {
      case RequestType.deposit:
        return successColor;
      case RequestType.withdrawal:
        return dangerColor;
      case RequestType.loan:
        return Colors.purple;
      case RequestType.advance:
        return Colors.orange;
    }
  }
}

// ------------------- Data Service (Mock) -------------------

class EmployeeDataService {
  static final EmployeeDataService _instance = EmployeeDataService._internal();
  factory EmployeeDataService() => _instance;
  EmployeeDataService._internal();

  // Current logged-in employee
  final Employee currentEmployee = Employee(
    id: 'EMP001',
    name: 'أحمد محمد علي',
    email: 'ahmed.mohamed@company.com',
    phone: '+20 100 123 4567',
    department: 'تكنولوجيا المعلومات',
    position: 'مطور تطبيقات',
    balance: 15000.0,
    joinDate: DateTime(2023, 3, 15),
  );

  final List<Request> _requests = [
    Request(
      id: 'REQ001',
      employeeId: 'EMP001',
      type: RequestType.withdrawal,
      amount: 2000.0,
      date: DateTime(2025, 8, 20, 10, 30),
      notes: 'سحب للمصاريف الشخصية',
      status: RequestStatus.approved,
      processedDate: DateTime(2025, 8, 21),
    ),
    Request(
      id: 'REQ002',
      employeeId: 'EMP001',
      type: RequestType.deposit,
      amount: 5000.0,
      date: DateTime(2025, 8, 22, 14, 15),
      notes: 'إيداع راتب إضافي',
      status: RequestStatus.processing,
    ),
    Request(
      id: 'REQ003',
      employeeId: 'EMP001',
      type: RequestType.advance,
      amount: 1500.0,
      date: DateTime(2025, 8, 23, 9, 45),
      notes: 'سلفة للطوارئ',
      status: RequestStatus.pending,
    ),
    Request(
      id: 'REQ004',
      employeeId: 'EMP001',
      type: RequestType.loan,
      amount: 10000.0,
      date: DateTime(2025, 8, 19, 16, 20),
      status: RequestStatus.rejected,
      adminNotes: 'يجب تقديم ضمانات إضافية',
      processedDate: DateTime(2025, 8, 20),
    ),
  ];

  List<Request> get myRequests => _requests.where((req) => req.employeeId == currentEmployee.id).toList();
  
  List<Request> getRequestsByStatus(RequestStatus status) {
    return myRequests.where((req) => req.status == status).toList();
  }

  List<Request> getPendingRequests() => getRequestsByStatus(RequestStatus.pending);
  List<Request> getApprovedRequests() => getRequestsByStatus(RequestStatus.approved);
  List<Request> getRejectedRequests() => getRequestsByStatus(RequestStatus.rejected);

  Map<String, int> getRequestsStats() {
    return {
      'pending': getPendingRequests().length,
      'approved': getApprovedRequests().length,
      'rejected': getRejectedRequests().length,
      'total': myRequests.length,
    };
  }

  void addRequest(Request request) {
    _requests.add(request);
  }

  double getTotalApprovedAmount() {
    return getApprovedRequests().fold(0, (sum, req) => sum + req.amount);
  }
}

// ------------------- Main Employee App -------------------

class MyMainApp extends StatefulWidget {
  @override
  _MyMainAppState createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final EmployeeDataService _dataService = EmployeeDataService();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text(message, style: TextStyle(fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  List<Widget> _pages() {
    return [
      _buildHomeScreen(),
      _buildMyRequestsScreen(),
      _buildNewRequestScreen(),
      _buildProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  _showNotifications();
                },
                icon: Icon(Icons.notifications_outlined),
              ),
              if (_dataService.getPendingRequests().isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${_dataService.getPendingRequests().length}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages().elementAt(_selectedIndex),
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'الصفحة الرئيسية';
      case 1:
        return 'طلباتي';
      case 2:
        return 'طلب جديد';
      case 3:
        return 'الملف الشخصي';
      default:
        return 'تطبيق الموظفين';
    }
  }

  Widget _buildDrawer() {
    final employee = _dataService.currentEmployee;
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [maincolor, maincolor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: maincolor.withOpacity(0.1),
                    child: Text(
                      employee.initials,
                      style: TextStyle(
                        color: maincolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  employee.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  employee.position,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(Icons.home_outlined, 'الرئيسية', 0),
                _buildDrawerItem(Icons.assignment_outlined, 'طلباتي', 1),
                _buildDrawerItem(Icons.add_circle_outline, 'طلب جديد', 2),
                _buildDrawerItem(Icons.person_outline, 'الملف الشخصي', 3),
                Divider(height: 32),
                ListTile(
                  leading: Icon(Icons.help_outline, color: Colors.grey[600]),
                  title: Text('المساعدة والدعم'),
                  onTap: () {
                    Navigator.pop(context);
                    _showHelpDialog();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings_outlined, color: Colors.grey[600]),
                  title: Text('الإعدادات'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSettingsDialog();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: dangerColor),
                  title: Text('تسجيل الخروج', style: TextStyle(color: dangerColor)),
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final isSelected = _selectedIndex == index;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? maincolor.withOpacity(0.1) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? maincolor : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? maincolor : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onTap: () => _onItemTapped(index),
      ),
    );
  }

  Widget _buildHomeScreen() {
    final stats = _dataService.getRequestsStats();
    final employee = _dataService.currentEmployee;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(employee),
          SizedBox(height: 24),
          _buildBalanceCard(employee),
          SizedBox(height: 24),
          _buildStatsGrid(stats),
          SizedBox(height: 24),
          _buildQuickActions(),
          SizedBox(height: 24),
          _buildRecentRequests(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(Employee employee) {
    final hour = DateTime.now().hour;
    String greeting = hour < 12 ? 'صباح الخير' : hour < 18 ? 'مساء الخير' : 'مساء الخير';
    
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [maincolor, maincolor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting، ${employee.name.split(' ')[0]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'مرحباً بك في تطبيق الموظفين',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                if (_dataService.getPendingRequests().isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    'لديك ${_dataService.getPendingRequests().length} طلبات معلقة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.work_outline,
              size: 48,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(Employee employee) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                color: successColor,
                size: 32,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الرصيد الحالي',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${employee.balance.toStringAsFixed(2)} جنيه مصري',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                setState(() {});
                _showSnackBar('تم تحديث الرصيد', successColor);
              },
              icon: Icon(Icons.refresh, color: maincolor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, int> stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(
          'إجمالي الطلبات',
          '${stats['total']}',
          Icons.assignment,
          maincolor,
        ),
        _buildStatCard(
          'طلبات معلقة',
          '${stats['pending']}',
          Icons.pending_actions,
          warningColor,
        ),
        _buildStatCard(
          'طلبات موافق عليها',
          '${stats['approved']}',
          Icons.check_circle,
          successColor,
        ),
        _buildStatCard(
          'طلبات مرفوضة',
          '${stats['rejected']}',
          Icons.cancel,
          dangerColor,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          if (title.contains('الطلبات')) {
            setState(() => _selectedIndex = 1);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                ],
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الإجراءات السريعة',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'طلب سحب',
                Icons.arrow_upward,
                dangerColor,
                () => _showNewRequestDialog(RequestType.withdrawal),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                'طلب سلفة',
                Icons.flash_on,
                Colors.orange,
                () => _showNewRequestDialog(RequestType.advance),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'طلب إيداع',
                Icons.arrow_downward,
                successColor,
                () => _showNewRequestDialog(RequestType.deposit),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                'طلب قرض',
                Icons.account_balance,
                Colors.purple,
                () => _showNewRequestDialog(RequestType.loan),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentRequests() {
    final recentRequests = _dataService.myRequests.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'أحدث الطلبات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => setState(() => _selectedIndex = 1),
              child: Text('عرض الكل'),
            ),
          ],
        ),
        SizedBox(height: 16),
        if (recentRequests.isEmpty)
          Card(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.inbox, size: 48, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'لا توجد طلبات حتى الآن',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'قم بإنشاء طلبك الأول',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ...recentRequests.map((request) => _buildRequestCard(request, isCompact: true)).toList(),
      ],
    );
  }

  Widget _buildMyRequestsScreen() {
    final myRequests = _dataService.myRequests;
    
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: maincolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.assignment, color: maincolor),
                      SizedBox(width: 8),
                      Text(
                        '${myRequests.length} طلب',
                        style: TextStyle(
                          color: maincolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => setState(() => _selectedIndex = 2),
                icon: Icon(Icons.add),
                label: Text('طلب جديد'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: successColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: myRequests.isEmpty
              ? _buildEmptyRequestsState()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: myRequests.length,
                  itemBuilder: (context, index) {
                    final request = myRequests[index];
                    return _buildRequestCard(request);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyRequestsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: maincolor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.assignment, size: 64, color: maincolor),
          ),
          SizedBox(height: 24),
          Text(
            'لا توجد طلبات حتى الآن',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'ابدأ بإنشاء طلبك الأول',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => setState(() => _selectedIndex = 2),
            icon: Icon(Icons.add),
            label: Text('إنشاء طلب جديد'),
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Request request, {bool isCompact = false}) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showRequestDetails(request),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? 16 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(isCompact ? 8 : 12),
                    decoration: BoxDecoration(
                      color: request.typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      request.typeIcon,
                      color: request.typeColor,
                      size: isCompact ? 20 : 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.typeString,
                          style: TextStyle(
                            fontSize: isCompact ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          '${request.amount.toStringAsFixed(2)} ج.م',
                          style: TextStyle(
                            fontSize: isCompact ? 14 : 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: request.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      request.statusString,
                      style: TextStyle(
                        color: request.statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              if (!isCompact) ...[
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[500]),
                    SizedBox(width: 8),
                    Text(
                      '${request.date.day}/${request.date.month}/${request.date.year} - ${request.date.hour.toString().padLeft(2, '0')}:${request.date.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (request.notes != null && request.notes!.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.note, size: 16, color: Colors.grey[500]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          request.notes!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewRequestScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إنشاء طلب جديد',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'اختر نوع الطلب الذي تريد إنشاؤه',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 32),
          _buildRequestTypeGrid(),
          SizedBox(height: 32),
          _buildRecentRequestsHistory(),
        ],
      ),
    );
  }

  Widget _buildRequestTypeGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildRequestTypeCard(
          'طلب سحب',
          'سحب مبلغ من رصيدك',
          Icons.arrow_upward,
          dangerColor,
          () => _showNewRequestDialog(RequestType.withdrawal),
        ),
        _buildRequestTypeCard(
          'طلب إيداع',
          'إيداع مبلغ في حسابك',
          Icons.arrow_downward,
          successColor,
          () => _showNewRequestDialog(RequestType.deposit),
        ),
        _buildRequestTypeCard(
          'طلب سلفة',
          'سلفة قصيرة الأجل',
          Icons.flash_on,
          Colors.orange,
          () => _showNewRequestDialog(RequestType.advance),
        ),
        _buildRequestTypeCard(
          'طلب قرض',
          'قرض طويل الأجل',
          Icons.account_balance,
          Colors.purple,
          () => _showNewRequestDialog(RequestType.loan),
        ),
      ],
    );
  }

  Widget _buildRequestTypeCard(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentRequestsHistory() {
    final recentRequests = _dataService.myRequests.take(5).toList();
    
    if (recentRequests.isEmpty) return SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'آخر الطلبات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 16),
        ...recentRequests.map((request) => _buildRequestCard(request, isCompact: true)).toList(),
      ],
    );
  }

  Widget _buildProfileScreen() {
    final employee = _dataService.currentEmployee;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfileHeader(employee),
          SizedBox(height: 24),
          _buildProfileDetails(employee),
          SizedBox(height: 24),
          _buildAccountSummary(),
          SizedBox(height: 24),
          _buildProfileActions(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Employee employee) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: maincolor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: maincolor.withOpacity(0.1),
                child: Text(
                  employee.initials,
                  style: TextStyle(
                    color: maincolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              employee.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: maincolor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                employee.position,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: maincolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetails(Employee employee) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المعلومات الشخصية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            _buildInfoRow(Icons.email, 'البريد الإلكتروني', employee.email),
            SizedBox(height: 16),
            _buildInfoRow(Icons.phone, 'رقم الهاتف', employee.phone),
            SizedBox(height: 16),
            _buildInfoRow(Icons.business, 'القسم', employee.department),
            SizedBox(height: 16),
            _buildInfoRow(Icons.badge, 'المنصب', employee.position),
            SizedBox(height: 16),
            _buildInfoRow(
              Icons.calendar_today,
              'تاريخ الانضمام',
              '${employee.joinDate.day}/${employee.joinDate.month}/${employee.joinDate.year}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Colors.grey[600]),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSummary() {
    final stats = _dataService.getRequestsStats();
    final totalApproved = _dataService.getTotalApprovedAmount();
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملخص الحساب',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'إجمالي الطلبات',
                    '${stats['total']}',
                    Icons.assignment,
                    maincolor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryItem(
                    'المبلغ المعتمد',
                    '${totalApproved.toStringAsFixed(0)} ج.م',
                    Icons.check_circle,
                    successColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileActions() {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: maincolor),
                title: Text('تعديل الملف الشخصي'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showEditProfileDialog(),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.orange),
                title: Text('تغيير كلمة المرور'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showChangePasswordDialog(),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue),
                title: Text('إعدادات الإشعارات'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showNotificationSettingsDialog(),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _showLogoutDialog,
            icon: Icon(Icons.logout),
            label: Text('تسجيل الخروج'),
            style: ElevatedButton.styleFrom(
              backgroundColor: dangerColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Dialog Methods
  void _showNewRequestDialog(RequestType type) {
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              type == RequestType.deposit ? Icons.arrow_downward :
              type == RequestType.withdrawal ? Icons.arrow_upward :
              type == RequestType.loan ? Icons.account_balance : Icons.flash_on,
              color: type == RequestType.deposit ? successColor :
                     type == RequestType.withdrawal ? dangerColor :
                     type == RequestType.loan ? Colors.purple : Colors.orange,
            ),
            SizedBox(width: 8),
            Text('طلب ${type == RequestType.deposit ? 'إيداع' : 
                       type == RequestType.withdrawal ? 'سحب' :
                       type == RequestType.loan ? 'قرض' : 'سلفة'}'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المبلغ المطلوب'),
              SizedBox(height: 8),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  hintText: 'أدخل المبلغ',
                  suffixText: 'ج.م',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text('ملاحظات (اختياري)'),
              SizedBox(height: 8),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: 'أضف ملاحظات للطلب',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
              ),
              if (type == RequestType.withdrawal) ...[
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'رصيدك الحالي: ${_dataService.currentEmployee.balance.toStringAsFixed(2)} ج.م',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount == null || amount <= 0) {
                _showSnackBar('يرجى إدخال مبلغ صحيح', dangerColor);
                return;
              }
              
              final newRequest = Request(
                id: 'REQ${DateTime.now().millisecondsSinceEpoch}',
                employeeId: _dataService.currentEmployee.id,
                type: type,
                amount: amount,
                date: DateTime.now(),
                notes: notesController.text.isNotEmpty ? notesController.text : null,
              );
              
              setState(() {
                _dataService.addRequest(newRequest);
              });
              
              Navigator.pop(context);
              _showSnackBar('تم إرسال الطلب بنجاح', successColor);
            },
            child: Text('إرسال الطلب'),
          ),
        ],
      ),
    );
  }

  void _showRequestDetails(Request request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(request.typeIcon, color: request.typeColor),
            SizedBox(width: 8),
            Text('تفاصيل الطلب'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem('رقم الطلب', request.id),
              _buildDetailItem('النوع', request.typeString),
              _buildDetailItem('المبلغ', '${request.amount.toStringAsFixed(2)} ج.م'),
              _buildDetailItem('الحالة', request.statusString),
              _buildDetailItem('التاريخ', '${request.date.day}/${request.date.month}/${request.date.year}'),
              _buildDetailItem('الوقت', '${request.date.hour.toString().padLeft(2, '0')}:${request.date.minute.toString().padLeft(2, '0')}'),
              if (request.notes != null && request.notes!.isNotEmpty)
                _buildDetailItem('ملاحظاتك', request.notes!),
              if (request.adminNotes != null && request.adminNotes!.isNotEmpty)
                _buildDetailItem('ملاحظات الإدارة', request.adminNotes!),
              if (request.processedDate != null)
                _buildDetailItem('تاريخ المعالجة', '${request.processedDate!.day}/${request.processedDate!.month}/${request.processedDate!.year}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
          if (request.status == RequestStatus.pending)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showCancelRequestDialog(request);
              },
              style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
              child: Text('إلغاء الطلب'),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
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

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('الإشعارات'),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: Column(
            children: [
              if (_dataService.getPendingRequests().isNotEmpty) ...[
                ListTile(
                  leading: Icon(Icons.pending_actions, color: warningColor),
                  title: Text('لديك ${_dataService.getPendingRequests().length} طلبات معلقة'),
                  subtitle: Text('قيد المراجعة من الإدارة'),
                ),
                Divider(),
              ],
              ListTile(
                leading: Icon(Icons.info, color: Colors.blue),
                title: Text('مرحباً بك في التطبيق'),
                subtitle: Text('يمكنك الآن إدارة طلباتك بسهولة'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showCancelRequestDialog(Request request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('إلغاء الطلب'),
        content: Text('هل أنت متأكد من إلغاء هذا الطلب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('تراجع'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('سيتم إضافة هذه الميزة قريباً', warningColor);
            },
            style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
            child: Text('إلغاء الطلب'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تسجيل الخروج'),
        content: Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('تم تسجيل الخروج بنجاح', successColor);
            },
            style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
            child: Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('المساعدة والدعم'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('للحصول على المساعدة، يمكنك التواصل معنا عبر:'),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, size: 20),
                SizedBox(width: 8),
                Text('support@company.com'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 8),
                Text('+20 100 000 0000'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('الإعدادات'),
        content: Text('سيتم إضافة الإعدادات قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل الملف الشخصي'),
        content: Text('سيتم إضافة هذه الميزة قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تغيير كلمة المرور'),
        content: Text('سيتم إضافة هذه الميزة قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('إعدادات الإشعارات'),
        content: Text('سيتم إضافة هذه الميزة قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}

// Main function
