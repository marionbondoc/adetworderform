class CartManager {
  static final List<Map<String, dynamic>> _cartItems = [];

  // Add a product to the cart with quantity
  static void addToCart(Map<String, dynamic> product, int quantity) {
    // Check if the product already exists in the cart
    for (var item in _cartItems) {
      if (item['name'] == product['name']) {
        // If the product exists, update its quantity
        item['quantity'] += quantity;
        return; // Exit the method to avoid adding a duplicate
      }
    }

    // If the product doesn't exist, add it to the cart
    _cartItems.add({
      'name': product['name'],
      'price': product['price'],
      'quantity': quantity,
      'image': product['image'], // Always add the image
    });
  }

  // Remove a product from the cart
  static void removeFromCart(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['name'] == product['name']);
  }

  // Check if a product is in the cart
  static bool isInCart(Map<String, dynamic> product) {
    return _cartItems.any((item) => item['name'] == product['name']);
  }

  // Get all cart items
  static List<Map<String, dynamic>> getCartItems() {
    return _cartItems;
  }

  // Clear all items from the cart
  static void clearCart() {
    _cartItems.clear();
  }
}
