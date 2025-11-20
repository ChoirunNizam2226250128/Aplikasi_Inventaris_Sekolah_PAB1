import 'dart:io';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'add_item_screen.dart';
import 'item_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = [
    Item(
      id: "1",
      name: "Laptop ASUS",
      category: "Elektronik",
      quantity: 10,
      location: "Ruang TU",
      imagePath: null,
    ),
    Item(
      id: "2",
      name: "Kursi Belajar",
      category: "Perabot",
      quantity: 30,
      location: "Kelas 7A",
      imagePath: null,
    ),
  ];

  void addItem(Item newItem) {
    setState(() => items.add(newItem));
  }

  void editItem(Item updatedItem) {
    setState(() {
      final index = items.indexWhere((i) => i.id == updatedItem.id);
      if (index != -1) items[index] = updatedItem;
    });
  }

  void deleteItem(String id) {
    setState(() => items.removeWhere((i) => i.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventaris Sekolah"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(username: widget.username),
                ),
              );
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text("Belum ada barang"))
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ItemDetailScreen(
                            item: item,
                            onEdit: editItem,
                            onDelete: () => deleteItem(item.id),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: item.imagePath != null
                                ? Image.file(
                                    File(item.imagePath!),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Container(
                                    color: Colors.indigo.shade100,
                                    child: const Center(
                                      child: Icon(
                                        Icons.inventory,
                                        size: 48,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 13, 193, 130),
        onPressed: () async {
          final newItem = await Navigator.push<Item>(
            context,
            MaterialPageRoute(builder: (_) => const AddItemScreen()),
          );
          if (newItem != null) addItem(newItem);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
