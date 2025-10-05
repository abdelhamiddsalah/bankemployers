import 'package:bankemployers/core/di/getit.dart';
import 'package:bankemployers/core/routing/app_routing.dart';
import 'package:bankemployers/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'BANKY',
      routerConfig: AppRouting.router,
    );
  }
}
