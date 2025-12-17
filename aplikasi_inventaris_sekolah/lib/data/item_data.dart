import '../models/item.dart';

class ItemData {
  static List<Item> items = [
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
}
