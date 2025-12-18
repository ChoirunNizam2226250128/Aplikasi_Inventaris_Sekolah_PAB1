import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';

class ItemData {
  static List<Item> items = [];

  static Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('items');

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      items = decoded.map((e) => Item.fromMap(e)).toList();
    } else {
      items = [
        Item(
          id: "1",
          name: "Laptop ASUS",
          category: "Elektronik",
          quantity: 10,
          location: "Ruang TU",
          imagePath: null,
          condition: "Baik",
          description: "Laptop inventaris sekolah untuk administrasi TU",
        ),
        Item(
          id: "2",
          name: "Kursi Belajar",
          category: "Perabot",
          quantity: 30,
          location: "Kelas 7A",
          imagePath: null,
          condition: "Baik",
          description: "Digunakan untuk kegiatan belajar mengajar",
        ),
      ];
      await saveItems();
    }
  }

  static Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(items.map((e) => e.toMap()).toList());
    await prefs.setString('items', jsonString);
  }
}
