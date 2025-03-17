import 'package:flutter/material.dart';
import 'package:practiceapp/screens/navbars/botbar.dart';
import 'package:practiceapp/screens/navbars/topbar.dart';
import 'package:practiceapp/utils/favorites_manager.dart';
import 'package:practiceapp/utils/cart_manager.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesManager.getFavorites();
    return Scaffold(
      appBar: TopBar(),
      drawer: TopBar.buildDrawer(context),
      body: Container(
        color: const Color(0xFF090C9B),
        child:
            favorites.isEmpty
                ? const Center(
                  child: Text(
                    "No favorites added yet!",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "OpenSans",
                      color: Colors.white,
                    ),
                  ),
                )
                : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            final favorite = favorites[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              leading: Image.asset(
                                favorite['image'],
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    favorite['name'],
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            FavoritesManager.removeFavorite(
                                              favorite,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            CartManager.addToCart(favorite, 1);
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("Added to cart!"),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
      ),
      bottomNavigationBar: BotBar(),
    );
  }
}
