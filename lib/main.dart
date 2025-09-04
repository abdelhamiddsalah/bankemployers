import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/admin/view/all_cvs_view.dart';
import 'package:bankemployers/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BANKY',
      home: AllCVsScreen(),
          );
  }
}