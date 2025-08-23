import 'package:bankemployers/features/auth/auth_view.dart';
import 'package:bankemployers/features/auth/widgets/animated_backround.dart';
import 'package:bankemployers/features/auth/widgets/contact_info_in_employer_sinup.dart';
import 'package:bankemployers/features/auth/widgets/employer_info_in_sinup.dart';
import 'package:bankemployers/features/auth/widgets/left_side_in_employer_signup.dart';
import 'package:bankemployers/features/auth/widgets/peronal_info_in_employer_signup.dart';
import 'package:bankemployers/features/auth/widgets/step_naviation_buttons.dart';
import 'package:bankemployers/features/auth/widgets/success_dialo.dart';
import 'package:bankemployers/features/auth/widgets/top_header_in_right_side.dart';
import 'package:flutter/material.dart';

class EmployeeSignupScreen extends StatefulWidget {
  const EmployeeSignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeSignupScreenState createState() => _EmployeeSignupScreenState();
}

class _EmployeeSignupScreenState extends State<EmployeeSignupScreen>
    with SingleTickerProviderStateMixin {
  
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  bool _isLoading = false;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessDialog(
        onGoToSignIn: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => EmployeeAuthScreen(),
            ),
          );
        },
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    }
  }
  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Row(
          children: [
            LeftSideInEmployerSignup(
              animationController: _animationController, 
              fadeAnimation: _fadeAnimation, 
              currentStep: _currentStep
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [        
                    TopHeaderInRightSide(currentStep: _currentStep),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: PageView(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            PersonalInfoStepWidget(),
                            ContactInfoInEmployerSinup(),
                            EmploymentInfoStepWidget(),
                          ],
                        ),
                      ),
                    ),
                    StepNavigationButtons(
                      currentStep: _currentStep,
                      isLoading: _isLoading,
                      onPrevious: _previousStep,
                      onNext: _nextStep,
                      onSubmit: _handleSignup,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}