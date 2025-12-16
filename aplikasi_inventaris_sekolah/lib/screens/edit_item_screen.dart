import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/item.dart';

class EditItemScreen extends StatefulWidget {
  final Item item;
  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String category;
  late int quantity;
  late String location;
  late String condition;
  late String description;

  File? imageFile;

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    category = widget.item.category;
    quantity = widget.item.quantity;
    location = widget.item.location;
    condition = widget.item.condition;
    description = widget.item.description;
  }

  void saveEdit() {
    final updatedItem = Item(
      id: widget.item.id,
      name: name,
      category: category,
      quantity: quantity,
      location: location,
      imagePath: imageFile?.path ?? widget.item.imagePath,
      condition: condition,
      description: description,
    );

    Navigator.pop(context, updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Barang")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              initialValue: name,
              decoration: const InputDecoration(labelText: "Nama Barang"),
              onChanged: (v) => name = v,
            ),
            TextFormField(
              initialValue: category,
              decoration: const InputDecoration(labelText: "Kategori"),
              onChanged: (v) => category = v,
            ),
            TextFormField(
              initialValue: quantity.toString(),
              decoration: const InputDecoration(labelText: "Jumlah"),
              keyboardType: TextInputType.number,
              onChanged: (v) => quantity = int.parse(v),
            ),
            TextFormField(
              initialValue: location,
              decoration: const InputDecoration(labelText: "Lokasi"),
              onChanged: (v) => location = v,
            ),

            // ===== KONDISI =====
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: condition,
              decoration: const InputDecoration(labelText: "Kondisi Barang"),
              items: const [
                DropdownMenuItem(value: "Baik", child: Text("Baik")),
                DropdownMenuItem(
                  value: "Rusak Ringan",
                  child: Text("Rusak Ringan"),
                ),
                DropdownMenuItem(
                  value: "Rusak Berat",
                  child: Text("Rusak Berat"),
                ),
              ],
              onChanged: (v) => condition = v!,
            ),

            // ===== DESKRIPSI =====
            const SizedBox(height: 12),
            TextFormField(
              initialValue: description,
              decoration: const InputDecoration(labelText: "Deskripsi"),
              maxLines: 3,
              onChanged: (v) => description = v,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveEdit,
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}
