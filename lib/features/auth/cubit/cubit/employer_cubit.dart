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



  // Sample employee data for authentication
  final Map<String, dynamic> sampleEmployee = {
    "firstName": "Ahmed",
    "lastName": "Salah",
    "email": "ahmed.salah@example.com",
    "password": "StrongPassword123",
    "phoneNumber": "01012345678",
    "nationalID": "30101010101234",
    "address": {
      "city": "Cairo",
      "zipCode": "12345"
    },
    "dateOfBirth": "1990-05-20",
    "employeeID": "EMP123",
    "jobTitle": "Software Engineer",
    "department": "IT",
    "dateOfHiring": "2023-01-01",
    "workBranch": "Cairo Branch",
    "maritalStatus": "Single",
    "gender": "MALE",
    "role": "EMPLOYEE"
  };

  Future<void> login() async {
    emit(EmployerLoading());

    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 2));

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Check credentials against sample data
      if (email == sampleEmployee['email'] && password == sampleEmployee['password']) {
        emit(EmployerSuccess(sampleEmployee));
      } else {
        emit(EmployerError('Invalid email or password'));
      }
    } catch (e) {
      emit(EmployerError('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  
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
