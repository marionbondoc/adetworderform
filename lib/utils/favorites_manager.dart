class FavoritesManager {
  static final List<Map<String, dynamic>> _favorites = [];

  static void addFavorite(Map<String, dynamic> product) {
    _favorites.add(product);
  }

  static void removeFavorite(Map<String, dynamic> product) {
    _favorites.removeWhere((item) => item['name'] == product['name']);
  }

  static bool isFavorite(Map<String, dynamic> product) {
    return _favorites.any((item) => item['name'] == product['name']);
  }

  static List<Map<String, dynamic>> getFavorites() {
    return _favorites;
  }
}
