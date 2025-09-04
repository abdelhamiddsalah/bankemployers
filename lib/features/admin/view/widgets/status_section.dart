import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/view/widgets/file_info.dart';
import 'package:bankemployers/features/admin/viewmodel/cvs/cubit/cvs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({super.key, required this.cv});
  final AllCvSModel cv;
  @override
  Widget build(BuildContext context) {
    return FileInfoSection(
      title: 'Application Status',
      icon: Icons.pending_actions,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:  cv.resultCv == 'approved'
                          ? Colors.green.shade100
                          : cv.resultCv == 'Waiting'
                              ? Colors.orange.shade100
                              : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: cv.resultCv == 'approved'
                          ? Colors.green
                          : cv.resultCv == 'Waiting'
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        cv.resultCv == 'approved'
                            ? Icons.check_circle
                            : cv.resultCv == 'Waiting'
                                ? Icons.pending
                                : Icons.cancel,
                        color: cv.resultCv == 'approved'
                          ? Colors.green
                          : cv.resultCv == 'Waiting'
                              ? Colors.orange
                              : Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        cv.resultCv == 'approved' ? 'Approved':  cv.resultCv == 'Waiting'? 'Pending': 'Rejected',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cv.resultCv == 'approved'
                          ? Colors.green
                          : cv.resultCv == 'Waiting'
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
     cv.resultCv == 'Waiting' ?     Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<CvsCubit>().putCvStatus(
                      cv.id,
                      'approved',
                      cv.salary,
                      cv.copoun,
                    );
                  },
                  icon: Icon(Icons.check, color: Colors.white),
                  label: Text(
                    'Approve',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<CvsCubit>().putCvStatus(
                      cv.id,
                      'Waiting',
                      cv.salary,
                      cv.copoun,
                    );
                  },
                  icon: Icon(Icons.pending, color: Colors.white),
                  label: Text(
                    'Pending',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),),
                  SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<CvsCubit>().putCvStatus(
                      cv.id,
                      'rejected',
                      cv.salary,
                      cv.copoun,
                    );
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                  label: Text(
                    'Rejected',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          )
        : SizedBox(),    
        ],
      ),
    );
  }
}
