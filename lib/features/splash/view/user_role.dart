import 'package:bankemployers/core/routing/routes.dart';
import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/empl_dadhboard.dart';
import 'package:bankemployers/features/employers_profile/view/empl_profile_view.dart';
import 'package:bankemployers/features/splash/view/widgets/right_side_widget_in_userchoice.dart';
import 'package:bankemployers/features/splash/view/widgets/role_selection_side.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String? selectedRole;
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
      selectedRole = role;
    });

    // Navigate based on selected role
    Future.delayed(Duration(milliseconds: 300), () {
      if (role == 'employer') {
        _navigateToEmployerLogin();
      } else if (role == 'admin') {
        _navigateToAdminLogin();
      }
    });
  }

  void _navigateToEmployerLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('signup_token');

    if (token != null && token.isNotEmpty) {
      // ✅ تحقق هل التوكن انتهت صلاحيته
      bool hasExpired = JwtDecoder.isExpired(token);

      if (hasExpired) {
        // ❌ لو انتهت الصلاحية → يروح للـ Signup
Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeProfileView()));

      } else {
        // ✅ لسه صالحة → يروح للـ Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UsersDashboard()),
        );
      }
    } else {
      // ❌ لو مفيش توكن أساسًا → Signup
      context.go(Routes.employersProfile);
    }
  }

  void _navigateToAdminLogin() {
    // Replace with your actual navigation
    print('Navigate to Admin Login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4F46E5), maincolor, Color(0xFF7C3AED)],
              ),
            ),
            child: isMobile
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        RightSideWidgetInUserChoice(
                          constraints: constraints,
                          fadeAnimation: _fadeAnimation,
                          isMobile: isMobile,
                        ),
                        RoleSelectionSide(
                          isMobile: isMobile,
                          fadeAnimation: _fadeAnimation,
                          slideAnimation: _slideAnimation,
                          onRoleSelected: _onRoleSelected,
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      RightSideWidgetInUserChoice(
                        constraints: constraints,
                        fadeAnimation: _fadeAnimation,
                        isMobile: isMobile,
                      ),
                      RoleSelectionSide(
                        isMobile: isMobile,
                        fadeAnimation: _fadeAnimation,
                        slideAnimation: _slideAnimation,
                        onRoleSelected: _onRoleSelected,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
