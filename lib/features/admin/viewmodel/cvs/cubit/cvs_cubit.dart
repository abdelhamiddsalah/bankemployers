import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/data/repos/admin_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'cvs_state.dart';

class CvsCubit extends Cubit<CvsState> {
  CvsCubit(this.adminRepo) : super(CvsInitial()){
    getAllCvs();
  }
  final AdminRepo adminRepo;
  TextEditingController salaryController = TextEditingController();
  TextEditingController copounController = TextEditingController();
  void getAllCvs() async {
    emit(CvsLoading());
    final result = await adminRepo.allCVs();
    result.fold((l) => emit(CvsFailure(l.errMessage)), (r) {
      emit(CvsSuccess(r));
    });
  }

  void putCvStatus(int id, String statusResult, double salary, String copoun) async {
    emit(CvsLoading());
    final result = await adminRepo.updateCvStatus(id: id, result: statusResult, salary: salary, copoun: copoun);
    result.fold((l) => emit(CvsFailure(l.errMessage)), (_) => getAllCvs());
  }
}
