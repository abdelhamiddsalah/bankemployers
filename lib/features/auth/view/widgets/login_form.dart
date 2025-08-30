import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/core/widgets/custom_textfield.dart';
import 'package:bankemployers/features/auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/auth/view/widgets/forget_pincode_in_signin.dart';
import 'package:bankemployers/features/auth/view/widgets/support_in_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.isLoading,
  });

  final GlobalKey<FormState> formKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sign in to your employee account',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 40),

                // Demo credentials info
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: maincolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: maincolor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🔑 Demo Credentials:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: maincolor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Email: ahmed.salah@example.com',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Password: StrongPassword123',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                BlocBuilder<EmployerCubit, EmployerState>(
                  builder: (context, state) {
                    return CustomTextField(
                      hintText: 'Enter your email address',
                      iconData: Icons.email_outlined,
                      controller: context.read<EmployerCubit>().emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    );
                  }
                ),
                SizedBox(height: 20),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                BlocBuilder<EmployerCubit, EmployerState>(
                  builder: (context, state) {
                    return CustomTextField(
                      hintText: 'Enter your password',
                      iconData: Icons.lock_outline,
                      obscureText: true,
                      controller: context.read<EmployerCubit>().passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    );
                  }
                ),
                SizedBox(height: 20),
                ForgetPinCodeInSignin(),
                SizedBox(height: 30),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: BlocConsumer<EmployerCubit, EmployerState>(
                    listener: (context, state) {
                      if (state is EmployerError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is EmployerSuccess) {
                        // Navigate to home page or show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login successful!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: isLoading ? null : () async {
                          if (formKey.currentState!.validate()) {
                          
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maincolor,
                          disabledBackgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Signing In...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    }
                  ),
                ),
                SizedBox(height: 30),
                ColumnInSigninSupport(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}