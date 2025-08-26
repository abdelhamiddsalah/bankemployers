import 'package:bankemployers/core/widgets/custom_textfield.dart';
import 'package:bankemployers/features/admin/view/widgets/admin_button_signup.dart';
import 'package:bankemployers/features/admin/viewmodel/cubits/admin/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginForm extends StatelessWidget {
  const AdminLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          child: Form(
            key: context.read<AdminCubit>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Admin',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sign in to your Admin account',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 40),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Enter your email address',
                  iconData: Icons.email_outlined,
                  controller: context.read<AdminCubit>().emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                CustomTextField(
                  hintText: 'Enter your password',
                  iconData: Icons.lock_outline,
                  obscureText: true,
                  controller: context.read<AdminCubit>().passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                BlocConsumer<AdminCubit, AdminState>(
                  listener: (context, state) {
                    if (state is AdminLoaded) {
                      // عند نجاح العملية
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message, 
                            style: TextStyle(color: Colors.white)
                          ), 
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      
                      // يمكنك إضافة navigation هنا إلى الصفحة التالية
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
                    }
                    if (state is AdminError) {
                      // عند حدوث خطأ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.errorMessage, 
                            style: TextStyle(color: Colors.white)
                          ), 
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AdminLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        )
                      );
                    }
                    return AdminButtonSignup(
                      onPressed: () {
                        if (context.read<AdminCubit>().formKey.currentState!.validate()) {
                          final email = context.read<AdminCubit>().emailController.text.trim();
                          final password = context.read<AdminCubit>().passwordController.text.trim();
                          
                          context.read<AdminCubit>().signupAdmin(email, password);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}