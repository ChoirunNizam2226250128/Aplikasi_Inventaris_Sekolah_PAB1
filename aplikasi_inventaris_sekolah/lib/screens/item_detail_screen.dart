import 'dart:io';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'edit_item_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  final Function(Item) onEdit;
  final VoidCallback onDelete;

  const ItemDetailScreen({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push<Item>(
                context,
                MaterialPageRoute(builder: (_) => EditItemScreen(item: item)),
              );
              if (updated != null) {
                onEdit(updated);
                Navigator.pop(context);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Hapus Barang"),
                  content: const Text("Yakin ingin menghapus barang ini?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                        Navigator.pop(context);
                      },
                      child: const Text("Hapus"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE =================
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: item.imagePath != null
                  ? Image.file(
                      File(item.imagePath!),
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.indigo.shade100),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // ================= TITLE =================
            Text(
              item.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // ================= INFO CARD =================
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _infoRow(
                      icon: Icons.category,
                      label: "Kategori",
                      value: item.category,
                    ),
                    const Divider(),
                    _infoRow(
                      icon: Icons.location_on,
                      label: "Lokasi",
                      value: item.location,
                    ),
                    const Divider(),
                    _infoRow(
                      icon: Icons.inventory_2,
                      label: "Jumlah",
                      value: "${item.quantity} unit",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INFO ROW =================
  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
