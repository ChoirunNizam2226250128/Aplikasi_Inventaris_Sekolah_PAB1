import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    category = widget.item.category;
    quantity = widget.item.quantity;
    location = widget.item.location;
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Nama Barang"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                onSaved: (v) => name = v!,
              ),
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(labelText: "Kategori"),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveEdit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text("Simpan Perubahan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
