import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/admin/view/admin_view.dart';
import 'package:bankemployers/features/empleyees/view/cv_upload_page.dart';
import 'package:bankemployers/features/empleyees/view/empl_dadhboard.dart';
import 'package:flutter/material.dart';

void main()async {
await  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: UsersDashboard(),

    );
  }
}
