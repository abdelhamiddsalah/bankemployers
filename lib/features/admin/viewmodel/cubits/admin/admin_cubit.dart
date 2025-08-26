import 'package:bankemployers/features/admin/data/models/admin_model.dart';
import 'package:bankemployers/features/admin/data/repos/admin_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepo adminRepo;
  AdminCubit({required this.adminRepo}) : super(AdminInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signupAdmin(String email, String password) async {
    emit(AdminLoading());
    final result = await adminRepo.signupAdmin(
      AdminModel(email: email, password: password),
    );
    result.fold(
      (failure) => emit(AdminError(errorMessage: failure.errMessage)),
      (message) => emit(AdminLoaded(message: message)),
    );
  }
}
