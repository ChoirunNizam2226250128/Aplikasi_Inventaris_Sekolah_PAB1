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
  File? imageFile;

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    category = widget.item.category;
    quantity = widget.item.quantity;
    location = widget.item.location;

    // Jika item sudah punya foto bawaan (URL), bisa ditampilkan nanti
  }

  Future pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void saveEdit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedItem = Item(
        id: widget.item.id,
        name: name,
        category: category,
        quantity: quantity,
        location: location,
        imagePath: imageFile?.path ?? widget.item.imagePath, // simpan foto
      );

      Navigator.pop(context, updatedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Barang"),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- FOTO BARANG ---
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image,
                              size: 70,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: pickImage,
                    icon: const Icon(Icons.upload, color: Colors.orange),
                    label: const Text(
                      "Ganti Foto",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- FORM DALAM CARD ---
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: name,
                        decoration: const InputDecoration(
                          labelText: "Nama Barang",
                        ),
                        validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                        onSaved: (v) => name = v!,
                      ),
                      TextFormField(
                        initialValue: category,
                        decoration: const InputDecoration(
                          labelText: "Kategori",
                        ),
                        validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                        onSaved: (v) => category = v!,
                      ),
                      TextFormField(
                        initialValue: quantity.toString(),
                        decoration: const InputDecoration(labelText: "Jumlah"),
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                        onSaved: (v) => quantity = int.parse(v!),
                      ),
                      TextFormField(
                        initialValue: location,
                        decoration: const InputDecoration(labelText: "Lokasi"),
                        validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                        onSaved: (v) => location = v!,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- TOMBOL SIMPAN ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
