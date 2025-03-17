import 'package:flutter/material.dart';
import 'package:practiceapp/screens/navbars/botbar.dart';
import 'package:practiceapp/screens/navbars/topbar.dart';
import 'package:practiceapp/utils/cart_manager.dart';
import 'package:practiceapp/screens/orderform.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool showOrderForm = false;

  void _handleCheckoutComplete() {
    setState(() {
      CartManager.clearCart();
      showOrderForm = false;
    });
    
    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
  
  // Add this function to handle the back button press from OrderForm
  void _handleBackPressed() {
    setState(() {
      showOrderForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager.getCartItems();

    // Calculate the total price of all items in the cart
    double totalPrice = cartItems.fold(0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });

    return Scaffold(
      appBar: TopBar(),
      drawer: TopBar.buildDrawer(context),
      body: Container(
        color: const Color(0xFF090C9B),
        child: cartItems.isEmpty && !showOrderForm
            ? const Center(
                child: Text(
                  "Your cart is empty!",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "OpenSans",
                    color: Colors.white,
                  ),
                ),
              )
            : showOrderForm
                ? OrderForm(
                    onCheckoutComplete: _handleCheckoutComplete,
                    onBackPressed: _handleBackPressed,
                    totalAmount: totalPrice,
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartItems[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              leading: Image.asset(
                                cartItem['image'] ?? 'assets/images/default.png',
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem['name'],
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    "Price: \$${cartItem['price']}",
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (cartItem['quantity'] > 1) {
                                              cartItem['quantity']--;
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${cartItem['quantity']}",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cartItem['quantity']++;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            CartManager.removeFromCart(cartItem);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.close,
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
                      // Total Price Section with Checkout Button
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$${totalPrice.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showOrderForm = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF090C9B),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                "Proceed to Checkout",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: BotBar(),
    );
  }
}