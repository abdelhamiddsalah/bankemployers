// widgets/employment_info_step_widget.dart

import 'package:bankemployers/core/widgets/custom_dropdown.dart';
import 'package:bankemployers/core/widgets/custom_textfield.dart';
import 'package:bankemployers/features/auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/view/widgets/data_selector_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmploymentInfoStepWidget extends StatefulWidget {
  const EmploymentInfoStepWidget({super.key});

  @override
  State<EmploymentInfoStepWidget> createState() => _EmploymentInfoStepWidgetState();
}

class _EmploymentInfoStepWidgetState extends State<EmploymentInfoStepWidget> {
  // Dropdown options
  final List<String> _jobTitles = [
    'Software Engineer', 'Data Analyst', 'Branch Manager', 'Teller',
    'Loan Officer', 'Customer Service', 'Security Officer', 'Accountant'
  ];
  
  final List<String> _departments = [
    'IT', 'Operations', 'Customer Service', 'Security',
    'Finance', 'Human Resources', 'Marketing', 'Risk Management'
  ];
  
  final List<String> _branches = [
    'Cairo Branch', 'Alexandria Branch', 'Giza Branch', 'Aswan Branch',
    'Luxor Branch', 'Suez Branch', 'Port Said Branch', 'Mansoura Branch'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employment Information',
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold, 
              color: Colors.grey[800]
            ),
          ),
          SizedBox(height: 20),
          
          // Employee ID and Hiring Date Row
          _buildEmployeeIdAndDateRow(),
          SizedBox(height: 20),
          
          // Job Title Field
          _buildJobTitleField(),
          SizedBox(height: 20),
          
          // Department Field
          _buildDepartmentField(),
          SizedBox(height: 20),
          
          // Work Branch Field
          _buildWorkBranchField(),
        ],
      ),
    );
  }

  Widget _buildEmployeeIdAndDateRow() {
    return Row(
      children: [
        Expanded(
          child: _buildFieldWithLabel(
            label: 'Employee ID',
            child: CustomTextField(
              hintText: 'Enter employee ID',
              iconData: Icons.badge_outlined,
              controller: context.read<EmployerCubit>().cveeController,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildFieldWithLabel(
            label: 'Date of Hiring',
            child: DateSelectorField(
              hintText: 'Select hiring date',
              controller: context.read<EmployerCubit>().dateOfHiringController,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobTitleField() {
    return _buildFieldWithLabel(
      label: 'Job Title',
      child: CustomDropdown(
        hintText: 'Select job title',
        iconData: Icons.work_outline,
        value: context.read<EmployerCubit>().selectedJobTitle,
        items: _jobTitles,
        onChanged: (value) => setState(() => 
          context.read<EmployerCubit>().selectedJobTitle = value
        ),
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildDepartmentField() {
    return _buildFieldWithLabel(
      label: 'Department',
      child: CustomDropdown(
        hintText: 'Select department',
        iconData: Icons.business_outlined,
        value: context.read<EmployerCubit>().selectedDapertment,
        items: _departments,
        onChanged: (value) => setState(() => 
          context.read<EmployerCubit>().selectedDapertment = value
        ),
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildWorkBranchField() {
    return _buildFieldWithLabel(
      label: 'Work Branch',
      child: CustomDropdown(
        hintText: 'Select work branch',
        iconData: Icons.account_balance_outlined,
        value: context.read<EmployerCubit>().selectedBranch,
        items: _branches,
        onChanged: (value) => setState(() => 
          context.read<EmployerCubit>().selectedBranch = value
        ),
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildFieldWithLabel({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: TextStyle(fontWeight: FontWeight.w600)
        ),
        SizedBox(height: 8),
        child,
      ],
    );
  }
}