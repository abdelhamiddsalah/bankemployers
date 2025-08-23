import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'employer_state.dart';

class EmployerCubit extends Cubit<EmployerState> {

  EmployerCubit() : super(EmployerInitial());
    final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIDController = TextEditingController();
  final employeeIDController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final dateOfHiringController = TextEditingController();
  
  // Dropdown values
  String? selectedJobTitle;
  String? selectedDepartment;
  String? selectedBranch;
  String? selectedMaritalStatus;
  String? selectedGender;

  
  void dispose() {
  
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    nationalIDController.dispose();
    employeeIDController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    dateOfBirthController.dispose();
    dateOfHiringController.dispose();
  }
}
