import 'package:flutter/material.dart';
import 'homecontrol.dart'; // Mengimpor halaman kontrol

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Auto Lamp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 22, 194, 108)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 16, 211, 162),
        ),
      ),
      home: const HomeControl(), // Mengarahkan langsung ke halaman kontrol
    );
  }
}
