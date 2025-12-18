class Item {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final String location;
  final String? imagePath;
  final String condition;
  final String description;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.location,
    this.imagePath,
    required this.condition,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'location': location,
      'imagePath': imagePath,
      'condition': condition,
      'description': description,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      quantity: map['quantity'],
      location: map['location'],
      imagePath: map['imagePath'],
      condition: map['condition'],
      description: map['description'],
    );
  }

  Item copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    String? location,
    String? imagePath,
    String? condition,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
      imagePath: imagePath ?? this.imagePath,
      condition: condition ?? this.condition,
      description: description ?? this.description,
    );
  }
}
