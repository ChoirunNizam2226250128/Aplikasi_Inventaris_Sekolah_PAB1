import 'dart:io';
import 'package:flutter/material.dart';

import '../models/item.dart';
import 'item_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Item> _allItems = [
    Item(
      id: "1",
      name: "Laptop ASUS",
      category: "Elektronik",
      quantity: 10,
      location: "Ruang TU",
      imagePath: null,
      condition: "Baik",
      description: "Laptop inventaris sekolah",
    ),
    Item(
      id: "2",
      name: "Kursi Belajar",
      category: "Perabot",
      quantity: 30,
      location: "Kelas 7A",
      imagePath: null,
      condition: "Baik",
      description: "Kursi untuk siswa",
    ),
  ];

  List<Item> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _searchItem(String query) {
    setState(() {
      _filteredItems = _allItems.where((item) {
        return item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cari Barang"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _searchItem,
              decoration: InputDecoration(
                hintText: "Cari nama atau kategori barang...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // ================= HASIL =================
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      "Barang tidak ditemukan",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemDetailScreen(
                                  item: item,
                                  onEdit: (_) {},
                                  onDelete: () {},
                                ),
                              ),
                            );
                          },
                          leading: item.imagePath != null
                              ? Image.file(
                                  File(item.imagePath!),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.inventory_2,
                                    color: Colors.indigo,
                                  ),
                                ),
                          title: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item.category),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
