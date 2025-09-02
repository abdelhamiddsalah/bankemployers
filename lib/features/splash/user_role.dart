import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/auth/view/employer_sinup_view.dart';
import 'package:bankemployers/features/cvs/view/cv_upload_page.dart';
import 'package:flutter/material.dart';

class UserRoleSelectionScreen extends StatefulWidget {
  const UserRoleSelectionScreen({super.key});

  @override
  State<UserRoleSelectionScreen> createState() =>
      _UserRoleSelectionScreenState();
}

class _UserRoleSelectionScreenState extends State<UserRoleSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? _selectedRole;
  bool _isHoveringEmployer = false;
  bool _isHoveringAdmin = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onRoleSelected(String role) {
    setState(() {
      _selectedRole = role;
    });

    // Navigate based on selected role
    Future.delayed(Duration(milliseconds: 300), () {
      if (role == 'employer') {
        // Navigate to Employee/Employer login
        _navigateToEmployerLogin();
      } else if (role == 'admin') {
        // Navigate to Admin login
        _navigateToAdminLogin();
      }
    });
  }

  void _navigateToEmployerLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>CVUploadPage()),
    );
  }

  void _navigateToAdminLogin() {
    // Replace with your actual navigation
    print('Navigate to Admin Login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4F46E5), maincolor, Color(0xFF7C3AED)],
          ),
        ),
        child: Row(
          children: [
            // Left Side - Branding
            _buildBrandingSide(),
            // Right Side - Role Selection
            _buildRoleSelectionSide(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandingSide() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(60),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bank Logo/Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.account_balance,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),

              // Main Title
              Text(
                'Bank Management\nSystem',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 20),

              // Subtitle
              Text(
                'Secure, Efficient, and User-Friendly\nBanking Solution for Modern Institutions',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40),

              // Features List
              _buildFeaturesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      'Advanced Security Protocols',
      'Real-time Transaction Processing',
      'Comprehensive User Management',
      'Detailed Analytics & Reports',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                feature,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRoleSelectionSide() {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.white,
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  Text(
                    'Welcome to Bank System',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Please select your role to continue',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 60),

                  // Role Selection Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildRoleCard(
                          title: 'Employee/Employer',
                          subtitle:
                              'Access employee portal and manage your account',
                          icon: Icons.business_center,
                          role: 'employer',
                          isHovering: _isHoveringEmployer,
                          onHover: (hovering) =>
                              setState(() => _isHoveringEmployer = hovering),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: _buildRoleCard(
                          title: 'Administrator',
                          subtitle:
                              'Full system access and administrative controls',
                          icon: Icons.admin_panel_settings,
                          role: 'admin',
                          isHovering: _isHoveringAdmin,
                          onHover: (hovering) =>
                              setState(() => _isHoveringAdmin = hovering),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  // Help Text
                  Text(
                    'Need help? Contact your system administrator',
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String role,
    required bool isHovering,
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () => _onRoleSelected(role),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 280,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: _selectedRole == role
                ? maincolor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _selectedRole == role
                  ? maincolor
                  : isHovering
                  ? maincolor.withOpacity(0.3)
                  : Colors.grey[300]!,
              width: _selectedRole == role ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovering
                    ? maincolor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: isHovering ? 20 : 10,
                offset: Offset(0, isHovering ? 10 : 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _selectedRole == role
                      ? maincolor
                      : isHovering
                      ? maincolor.withOpacity(0.1)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: _selectedRole == role
                      ? Colors.white
                      : isHovering
                      ? maincolor
                      : Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),

              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _selectedRole == role ? maincolor : Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),

              // Subtitle
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Selection Indicator
              _selectedRole == 'employer'
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Selected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
