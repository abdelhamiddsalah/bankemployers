import 'package:bankemployers/features/auth/data/model/auth_response.dart';
import 'package:bankemployers/features/auth/data/model/empolyee_model.dart';
import 'package:bankemployers/features/auth/data/repo/singnup_emplyee.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final zipCodeController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final dateOfHiringController = TextEditingController();
    final formKey = GlobalKey<FormState>();
     final personalInfoFormKey = GlobalKey<FormState>();
   final personalInfoFsormKey = GlobalKey<FormState>();
   final cveeController = TextEditingController();
   final materialstate= TextEditingController();

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
    "jobTitle": "Software Engineer",
    "department": "IT",
    "dateOfHiring": "2023-01-01",
    "workBranch": "Cairo Branch",
    "maritalStatus": "Single",
    "gender": "MALE",
    "role": "EMPLOYEE",
     "cvee": {
    "copoun": "MP05" 
  }
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
    cityController.dispose();
    zipCodeController.dispose();
    dateOfBirthController.dispose();
    pinCodeController.dispose();
    dateOfHiringController.dispose();
    cveeController.dispose(); // جديد
  }

  
Future<void> signupEmployer(Employee employer) async {
  emit(EmployerLoading());

  try {
    await employesRepo.signupEmployee(employer).then((response) async {
      response.fold(
        (failure) => emit(EmployerError(failure.errMessage)),
        (authResponse) async {
          // ✅ Save token
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('signup_token', authResponse.token );
          emit(EmployerSuccess(authResponse));
        },
      );
    });
  } catch (e) {
    emit(EmployerError(e.toString()));
  }
  emit(EmployerInitial());
}

Future<void> loginEmployee(String email, String pincode) async {
  emit(EmployerLoading());

  try {
    await employesRepo.loginEmployee(email, pincode).then((response) async {
      response.fold(
        (failure) => emit(EmployerError(failure.errMessage)),
        (authResponse) async {
          // ✅ Save token
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('signup_token', authResponse.token);
          emit(EmployerSuccess(authResponse));
        },
      );
    });
  } catch (e) {
    emit(EmployerError(e.toString()));
  }
  emit(EmployerInitial());
}

}
