import 'package:flutter/material.dart';
import 'package:practiceapp/screens/navbars/botbar.dart';
import 'package:practiceapp/screens/navbars/topbar.dart';
import 'package:practiceapp/utils/favorites_manager.dart';
import 'package:practiceapp/utils/cart_manager.dart';

class ProductTwoCard extends StatefulWidget {
  const ProductTwoCard({super.key});

  @override
  State<ProductTwoCard> createState() => _ProductTwoCardState();
}

class _ProductTwoCardState extends State<ProductTwoCard> {
  int quantity = 1;

  // Product details
  final Map<String, dynamic> product = {
    'image': "assets/images/product2.jpg",
    'name': "Product 2",
    'price': 200.00,
    'description':
        "This is a detailed description of the product. It provides more information about the product's features and benefits.",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      drawer: TopBar.buildDrawer(context),
      body: Column(
        children: [
          // Top Section: Back Button, Product Name, and Image
          Stack(
            children: [
              Container(
                color: const Color(0xFF090C9B),
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    // Product Name
                    Center(
                      child: Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Product Image
                    Center(
                      child: Image.asset(
                        product['image'],
                        height: 400.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              // Back Button Positioned at the Top-Left
              Positioned(
                top: 16.0,
                left: 16.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ),
            ],
          ),
          // Bottom Section: Price, Description, Quantity, and Add to Cart
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFB4C5E4),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Price
                      Text(
                        "\$${product['price']}",
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Favorite Button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (FavoritesManager.isFavorite(product)) {
                              FavoritesManager.removeFavorite(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Removed from favorites!"),
                                ),
                              );
                            } else {
                              FavoritesManager.addFavorite(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added to favorites!"),
                                ),
                              );
                            }
                          });
                        },
                        child: Icon(
                          FavoritesManager.isFavorite(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  // Product Description
                  Text(
                    product['description'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: "OpenSans",
                      color: Colors.white,
                    ),
                  ),
                  // Quantity Selector and Add to Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Selector
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: const Icon(Icons.remove, color: Colors.white),
                          ),
                          Text(
                            "$quantity",
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontFamily: "OpenSans",
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                      // Add to Cart Button
                      SizedBox(
                        width: 200.0, // Set the width of the button
                        height: 50.0, // Set the height of the button
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              // Check if the product is already in the cart
                              if (CartManager.isInCart(product)) {
                                // If it exists, update the quantity and show a message
                                CartManager.addToCart(product, quantity);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Product already in cart. Quantity updated!",
                                    ),
                                  ),
                                );
                              } else {
                                // If it doesn't exist, add it to the cart and show a message
                                CartManager.addToCart(product, quantity);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Added to cart!"),
                                  ),
                                );
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Color(0xFF090C9B),
                            size: 24.0,
                          ),
                          label: const Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Color(0xFF090C9B),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotBar(),
    );
  }
}
