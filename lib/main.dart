import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/features/admin/view/admin_view.dart';
import 'package:flutter/material.dart';

void main()async {
await  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: AdminView(),

    );
  }
}
