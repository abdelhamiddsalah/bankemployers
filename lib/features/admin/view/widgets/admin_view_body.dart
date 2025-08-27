import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/admin/view/widgets/admin_login_form.dart';
import 'package:bankemployers/features/admin/view/widgets/left_side_in_admin.dart';
import 'package:flutter/material.dart';
class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminSigninViewBodyState createState() => _AdminSigninViewBodyState();
}

class _AdminSigninViewBodyState extends State<AdminViewBody> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4338CA), maincolor, Color(0xFF8B5CF6)],
          ),
        ),
        child: Row(
          children: [
            // Left side - Branding
            LeftSideInAdmin(
              animationController: _animationController,
              fadeAnimation: _fadeAnimation,
            ),

            // Right side - Login Form
            Expanded(
              flex: 1,
              child: Material(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(60),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: AdminLoginForm(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}