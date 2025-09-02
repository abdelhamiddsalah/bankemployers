import 'package:bankemployers/features/auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactInfoInEmployerSinup extends StatelessWidget {
  const ContactInfoInEmployerSinup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<EmployerCubit>().personalInfoFsormKey,
      child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
                SizedBox(height: 20),
                
                Text('Phone Number', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Enter phone number',
                  iconData: Icons.phone_outlined,
                  controller: context.read<EmployerCubit>().phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Required';
                    if (value!.length < 10) return 'Invalid phone number';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                
                Text('National ID', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Enter national ID',
                  iconData: Icons.credit_card_outlined,
                  controller: context.read<EmployerCubit>().nationalIDController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Required';
                    if (value!.length != 14) return 'Must be 14 digits';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(hintText: 'Enter PinCode',
                 iconData: Icons.lock_outline, 
                 controller: context.read<EmployerCubit>().pinCodeController,
                 keyboardType: TextInputType.number,
                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                 validator: (value) {
                   if (value?.isEmpty ?? true) return 'Required';
                   if (value!.length != 6) return 'Must be 6 digits';
                   return null;
                 },
                 ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('City', style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Enter city',
                            iconData: Icons.location_city_outlined,
                            controller: context.read<EmployerCubit>().cityController,
                            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ZIP Code', style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'ZIP code',
                            iconData: Icons.location_on_outlined,
                            controller: context.read<EmployerCubit>().zipCodeController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
