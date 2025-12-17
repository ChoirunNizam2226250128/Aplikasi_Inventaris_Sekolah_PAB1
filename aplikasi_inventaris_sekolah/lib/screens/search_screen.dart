import 'dart:io';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../data/item_data.dart';
import 'item_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Item> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    // AWALNYA TAMPILKAN SEMUA BARANG
    _filteredItems = List.from(ItemData.items);
  }

  void _searchItem(String query) {
    setState(() {
      _filteredItems = ItemData.items.where((item) {
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
          // ===== SEARCH BAR =====
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

          // ===== HASIL =====
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
                        child: ListTile(
                          leading: item.imagePath != null
                              ? Image.file(
                                  File(item.imagePath!),
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.inventory_2,
                                  color: Colors.indigo,
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
