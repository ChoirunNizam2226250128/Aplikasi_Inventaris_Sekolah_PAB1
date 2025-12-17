import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // ✅ TAMBAH INI
import 'screens/login_screen.dart';

void main() {
  runApp(const InventarisApp());
}

class InventarisApp extends StatelessWidget {
  const InventarisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris Sekolah',
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),

      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 91, 104, 19),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
    );
  }
}
