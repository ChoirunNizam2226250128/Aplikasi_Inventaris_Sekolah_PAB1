import 'dart:io';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../data/item_data.dart';
import '../data/favorite_data.dart';
import 'add_item_screen.dart';
import 'item_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addItem(Item newItem) {
    setState(() {
      ItemData.items.add(newItem);
    });
  }

  void editItem(Item updatedItem) {
    setState(() {
      final index = ItemData.items.indexWhere((i) => i.id == updatedItem.id);
      if (index != -1) {
        ItemData.items[index] = updatedItem;
      }
    });
  }

  void deleteItem(String id) {
    setState(() {
      ItemData.items.removeWhere((i) => i.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = ItemData.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inventaris Sekolah",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo.shade400,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade400, Colors.indigo.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, ${widget.username} 👋",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Kelola inventaris sekolah dengan mudah",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    _infoBox(
                      icon: Icons.inventory_2,
                      title: "Total Barang",
                      value: items.length.toString(),
                    ),
                    const SizedBox(width: 12),
                    _infoBox(
                      icon: Icons.favorite,
                      title: "Favorit",
                      value: FavoriteData.favoriteItems.length.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================= GRID BARANG =================
          Expanded(
            child: Padding(
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
                  return _buildItemCard(item);
                },
              ),
            ),
          ),
        ],
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

  // ================= ITEM CARD =================
  Widget _buildItemCard(Item item) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade200,
                                Colors.indigo.shade100,
                              ],
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
                      Text(
                        "Jumlah: ${item.quantity}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ❤️ FAVORIT
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    FavoriteData.toggleFavorite(item);
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    FavoriteData.isFavorite(item)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INFO BOX =================
  Widget _infoBox({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
