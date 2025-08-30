import 'package:bankemployers/features/auth/data/model/auth_response.dart';
import 'package:bankemployers/features/auth/data/model/empolyee_model.dart';
import 'package:bankemployers/features/auth/data/repo/singnup_emplyee.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'employer_state.dart';

class EmployerCubit extends Cubit<EmployerState> {

  EmployerCubit(this.employesRepo) : super(EmployerInitial());
  final SingnupEmplyee employesRepo ;
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
    final formKey = GlobalKey<FormState>();
     final personalInfoFormKey = GlobalKey<FormState>();
   final personalInfoFsormKey = GlobalKey<FormState>();
   // employerInfoFormKey = GlobalKey<FormState>();
  // Dropdown values
  String? selectedJobTitle;
  String? selectedMaterail;
  String? selectedDapertment;
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

  Future<void> signupEmployer(Employee employer) async {
    emit(EmployerLoading());

    try {
      await employesRepo.signupEmployee(employer).then((response) {
        response.fold(
          (failure) => emit(EmployerError(failure.errMessage)),
          (message) => emit(EmployerSuccess(message)),
        );
      });
    } catch (e) {
      emit(EmployerError(e.toString()));
    }
    emit(EmployerInitial());
  }
}
