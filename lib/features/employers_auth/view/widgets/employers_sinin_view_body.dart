import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/employers_auth/view/widgets/left_side_in_signin.dart';
import 'package:bankemployers/features/employers_auth/view/widgets/login_form.dart';
import 'package:bankemployers/features/employers_auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployersSininViewBody extends StatefulWidget {
  const EmployersSininViewBody({super.key});

  @override
  _EmployersSininViewBodyState createState() => _EmployersSininViewBodyState();
}

class _EmployersSininViewBodyState extends State<EmployersSininViewBody> 
    with SingleTickerProviderStateMixin {
  
  final _formKey = GlobalKey<FormState>();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample employee data for authentication

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

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

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
            colors: [
              Color(0xFF4338CA),
              maincolor,
              Color(0xFF8B5CF6),
            ],
          ),
        ),
        child: Row(
          children: [
            // Left side - Branding
            LeftSideInSignin(
              animationController: _animationController, 
              fadeAnimation: _fadeAnimation
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(60),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: BlocBuilder<EmployerCubit, EmployerState>(
                          builder: (context, state) {
                            final isLoading = state is EmployerLoading;                   
                            return LoginForm(
                              formKey: _formKey,
                              isLoading: isLoading,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}