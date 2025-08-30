import 'package:bankemployers/core/databases/cache/cache_helper.dart';
import 'package:bankemployers/features/auth/data/model/empolyee_model.dart';
import 'package:bankemployers/features/auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/view/widgets/animated_backround.dart';
import 'package:bankemployers/features/auth/view/widgets/contact_info_in_employer_sinup.dart';
import 'package:bankemployers/features/auth/view/widgets/left_side_in_employer_signup.dart';
import 'package:bankemployers/features/auth/view/widgets/peronal_info_in_employer_signup.dart';
import 'package:bankemployers/features/auth/view/widgets/step_naviation_buttons.dart';
import 'package:bankemployers/features/auth/view/widgets/top_header_in_right_side.dart';
import 'package:bankemployers/features/auth/view/widgets/employer_info_in_sinup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeSignupScreen extends StatefulWidget {
  const EmployeeSignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeSignupScreenState createState() => _EmployeeSignupScreenState();
}

class _EmployeeSignupScreenState extends State<EmployeeSignupScreen>
    with SingleTickerProviderStateMixin {
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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      if (_currentStep == 0) {
        if (context.read<EmployerCubit>().personalInfoFormKey.currentState!.validate()) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentStep++;
          });
        }
      } else if (_currentStep == 1) {
        if (context.read<EmployerCubit>().personalInfoFsormKey.currentState!.validate()) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentStep++;
          });
        }
      } else {
  _pageController.nextPage(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  setState(() {
    _currentStep++;
  });
}
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
      body: BlocConsumer<EmployerCubit, EmployerState>(
        listener: (context, state) {
          if (state is EmployerSuccess) {
              CacheHelper.sharedPreferences.setString('token', state.authResponse.token);
             ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup successful!')),
          );
          }else if (state is EmployerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          } else if (state is EmployerLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
          }
        },
        builder: (context, state) {
          return AnimatedBackground(
            child: Row(
              children: [
                LeftSideInEmployerSignup(
                  animationController: _animationController,
                  fadeAnimation: _fadeAnimation,
                  currentStep: _currentStep,
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
                            key: context.read<EmployerCubit>().formKey,
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
                          onSubmit: () {
                            if (context
                                .read<EmployerCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<EmployerCubit>().signupEmployer(
                                Employee(
                                  firstName: context
                                      .read<EmployerCubit>()
                                      .firstNameController
                                      .text,
                                  lastName: context
                                      .read<EmployerCubit>()
                                      .lastNameController
                                      .text,
                                  email: context
                                      .read<EmployerCubit>()
                                      .emailController
                                      .text,
                                  password: context
                                      .read<EmployerCubit>()
                                      .passwordController
                                      .text,
                                  phoneNumber: context
                                      .read<EmployerCubit>()
                                      .phoneController
                                      .text,
                                  nationalID: context
                                      .read<EmployerCubit>()
                                      .nationalIDController
                                      .text,
                                  pincode: context
                                      .read<EmployerCubit>()
                                      .phoneController
                                      .text,
                                  address: Address(
                                    city: context
                                        .read<EmployerCubit>()
                                        .cityController
                                        .text,
                                    zipCode: context
                                        .read<EmployerCubit>()
                                        .zipCodeController
                                        .text,
                                  ),
                                  dateOfBirth: context
                                      .read<EmployerCubit>()
                                      .dateOfBirthController
                                      .text,
                                  emplyeeID: context
                                      .read<EmployerCubit>()
                                      .employeeIDController
                                      .text,
                                  jobTitle: context
                                      .read<EmployerCubit>()
                                      .selectedJobTitle
                                      .toString(),
                                  department: context
                                      .read<EmployerCubit>()
                                      .selectedDapertment
                                      .toString(),
                                  dateOfHiring: context
                                      .read<EmployerCubit>()
                                      .dateOfHiringController
                                      .text,
                                  workBranch: context
                                      .read<EmployerCubit>()
                                      .selectedBranch
                                      .toString(),
                                  materialStatus: 'materialStatus',
                                  gender: context
                                      .read<EmployerCubit>()
                                      .selectedGender
                                      .toString(),
                                  role: "EMPLOYER",
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
