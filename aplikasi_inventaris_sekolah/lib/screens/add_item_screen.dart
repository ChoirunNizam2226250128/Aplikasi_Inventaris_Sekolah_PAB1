import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/item.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String condition = "Baik"; // default

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveItem() {
    if (nameController.text.isEmpty) return;

    final newItem = Item(
      id: DateTime.now().toString(),
      name: nameController.text,
      category: categoryController.text,
      quantity: int.tryParse(quantityController.text) ?? 0,
      location: locationController.text,
      imagePath: _image?.path,
      condition: condition,
      description: descriptionController.text,
    );

    Navigator.pop(context, newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Barang"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _image != null
                  ? Image.file(_image!, height: 180, fit: BoxFit.cover)
                  : Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(Icons.add_a_photo, size: 40),
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Barang"),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Kategori"),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: "Jumlah"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Lokasi"),
            ),

            // ===== KONDISI BARANG =====
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
              onChanged: (v) => setState(() => condition = v!),
            ),

            // ===== DESKRIPSI =====
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
              maxLines: 3,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveItem,
              child: const Text("Simpan Barang"),
            ),
          ],
        ),
      ),
    );
  }
}
