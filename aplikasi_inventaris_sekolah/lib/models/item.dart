class Item {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final String location;
  final String? imagePath; // nullable supaya tidak wajib ada foto

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.location,
    this.imagePath,
  });

  // Utility agar mudah update sebagian field
  Item copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    String? location,
    String? imagePath,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
