import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/home/view/viewmodel/cubits/employer_cubit/cubit/employers_cubit.dart';
import 'package:bankemployers/features/home/view/widgets/employers_settins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListCard extends StatelessWidget {
  const EmployeeListCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployersCubit, EmployersState>(
      builder: (context, state) {
        if (state is! EmployersLoaded) {
          return SizedBox();
        }

        final employers = state.employers;
        
        if (employers.isEmpty || index >= employers.length) {
          return SizedBox();
        }

        final employee = employers[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [maincolor.withOpacity(0.8), maincolor],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          employee.firstName.isNotEmpty && employee.lastName.isNotEmpty
                              ? employee.firstName[0].toUpperCase() + employee.lastName[0].toUpperCase()
                              : employee.firstName.isNotEmpty 
                                  ? employee.firstName[0].toUpperCase()
                                  : '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${employee.firstName} ${employee.lastName}', // Fixed this line
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            employee.jobTitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: maincolor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            employee.department,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  employee.email,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    EmployersSettins(employerId: employee.id.toString(),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
