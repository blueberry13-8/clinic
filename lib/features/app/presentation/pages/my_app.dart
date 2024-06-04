import 'package:flutter/material.dart';
import 'auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Регистратура',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 20, color: Colors.black),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      home: const AuthPage(),
    );
  }
}