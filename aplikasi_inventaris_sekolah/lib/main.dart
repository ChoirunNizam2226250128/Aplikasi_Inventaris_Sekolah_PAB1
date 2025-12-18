import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'data/item_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ LOAD DATA BARANG DARI STORAGE
  await ItemData.loadItems();

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
