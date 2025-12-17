import '../models/item.dart';

class FavoriteData {
  static List<Item> favoriteItems = [];

  static bool isFavorite(Item item) {
    return favoriteItems.any((i) => i.id == item.id);
  }

  static void toggleFavorite(Item item) {
    if (isFavorite(item)) {
      favoriteItems.removeWhere((i) => i.id == item.id);
    } else {
      favoriteItems.add(item);
    }
  }
}
