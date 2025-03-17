import 'package:flutter/material.dart';
import 'package:practiceapp/screens/menu/products/product2/product2card.dart';

class ProductTwo extends StatelessWidget {
  const ProductTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductTwoCard()),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product Image
              Image.asset(
                "assets/images/product2.jpg",
                height: 120.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              // Product Label
              const Text(
                "Product 2",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                ),
              ),
              const SizedBox(height: 5),
              // Product Price
              const Text(
                "150.00",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "OpenSans",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
