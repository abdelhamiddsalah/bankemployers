// widgets/personal_info_step_widget.dart
import 'package:bankemployers/features/employers_auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/employers_auth/view/widgets/data_selector_field.dart';
import 'package:bankemployers/core/widgets/custom_dropdown.dart';
import 'package:bankemployers/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PersonalInfoStepWidget extends StatefulWidget {
  const PersonalInfoStepWidget({super.key});

  @override
  State<PersonalInfoStepWidget> createState() => _PersonalInfoStepWidgetState();
}

class _PersonalInfoStepWidgetState extends State<PersonalInfoStepWidget> {
  final List<String> _genders = ['MALE', 'FEMALE'];
  final List<String> matematerialStatus = [
    'Single', 'Married', 'Divorced', 'Widowed'
  ];  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: context.read<EmployerCubit>().personalInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: Colors.grey[800]
              ),
            ),
            SizedBox(height: 20),
            
            // Name Fields Row
            _buildNameFields(),
            SizedBox(height: 20),
            
            // Email Field
            _buildEmailField(),
            SizedBox(height: 20),
            
            // Password Fields
            _buildPasswordFields(),
            SizedBox(height: 20),
            
            // Date and Gender Row
            _buildDateAndGenderRow(),
            SizedBox(height: 20),
        
            _buildMatematerialStatusField()
          ],
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: _buildFieldWithLabel(
            label: 'First Name',
            child: CustomTextField(
              hintText: 'Enter first name',
              iconData: Icons.person_outline,
              controller: context.read<EmployerCubit>().firstNameController,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildFieldWithLabel(
            label: 'Last Name',
            child: CustomTextField(
              hintText: 'Enter last name',
              iconData: Icons.person_outline,
              controller: context.read<EmployerCubit>().lastNameController,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return _buildFieldWithLabel(
      label: 'Email Address',
      child: CustomTextField(
        hintText: 'Enter email address',
        iconData: Icons.email_outlined,
        controller: context.read<EmployerCubit>().emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Required';
          if (!value!.contains('@')) return 'Invalid email';
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        _buildFieldWithLabel(
          label: 'Password',
          child: CustomTextField(
            hintText: 'Enter password',
            iconData: Icons.lock_outline,
            controller: context.read<EmployerCubit>().passwordController,
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (value!.length < 8) return 'Minimum 8 characters';
              return null;
            },
          ),
        ),
        SizedBox(height: 20),
        _buildFieldWithLabel(
          label: 'Confirm Password',
          child: CustomTextField(
            hintText: 'Confirm password',
            iconData: Icons.lock_outline,
            controller: context.read<EmployerCubit>().confirmPasswordController,
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (value != context.read<EmployerCubit>().passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndGenderRow() {
    return Row(
      children: [
        Expanded(
          child: _buildFieldWithLabel(
            label: 'Date of Birth',
            child: DateSelectorField(
              hintText: 'Select date of birth',
              controller: context.read<EmployerCubit>().dateOfBirthController,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildFieldWithLabel(
            label: 'Gender',
            child: CustomDropdown(
              hintText: 'Select gender',
              iconData: Icons.person_outline,
              value: context.read<EmployerCubit>().selectedGender,
              items: _genders,
              onChanged: (value) => setState(() => 
                context.read<EmployerCubit>().selectedGender = value
              ),
              validator: (value) => value == null ? 'Required' : null,
            ),
          ),
        ),
      ],
    );
  }

    Widget _buildMatematerialStatusField() {
    return _buildFieldWithLabel(
      label: 'mathematical Status',
      child: CustomDropdown(
        hintText: 'Select mathematical status',
        iconData: Icons.business_outlined,
        value: context.read<EmployerCubit>().selectedMaterail,
        items: matematerialStatus,
        onChanged: (value) => setState(() => 
          context.read<EmployerCubit>().selectedMaterail = value
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