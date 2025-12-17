import 'dart:io';
import 'package:flutter/material.dart';

import '../data/favorite_data.dart';
import '../models/item.dart';
import 'item_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Item> favorites = FavoriteData.favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Barang Favorit"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "Belum ada barang favorit",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: item.imagePath != null
                        ? Image.file(
                            File(item.imagePath!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.inventory_2, color: Colors.indigo),
                    title: Text(item.name),
                    subtitle: Text(item.category),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          FavoriteData.favoriteItems.removeWhere(
                            (i) => i.id == item.id,
                          );
                        });
                      },
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
    );
  }
}
