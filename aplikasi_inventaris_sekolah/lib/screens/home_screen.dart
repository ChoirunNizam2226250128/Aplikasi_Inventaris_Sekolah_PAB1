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
                  childAspectRatio: 0.82,
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
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ================= IMAGE =================
                          Expanded(
                            child: item.imagePath != null
                                ? Image.file(
                                    File(item.imagePath!),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigo.shade200,
                                          Colors.indigo.shade100,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.inventory_2_rounded,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),

                          // ================= INFO =================
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.category,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.inventory,
                                      size: 14,
                                      color: Colors.indigo,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Jumlah: ${item.quantity}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
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
