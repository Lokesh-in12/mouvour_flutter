import 'package:flutter/material.dart';
import 'package:mouvour_flutter/presentation/pages/HomePage/home_page.dart';
import 'package:mouvour_flutter/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.home  : (context) => HomePage(),
      },
    );
  }
}
