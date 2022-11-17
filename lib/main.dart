import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trabalho_mobile/src/login.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho mobile',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Login(),
    );
  }
}
