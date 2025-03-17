import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  // Function to open URLs
  static void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Drawer Widget
  static Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header with Logo
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFFBFFF1)),
            child: Center(
              child: Image.asset("assets/images/logo2.png", height: 300.0),
            ),
          ),
          // Navigation Links
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text("Menu"),
            onTap: () {
              Navigator.pushNamed(context, "/menu");
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Orders"),
            onTap: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () {
              Navigator.pushNamed(context, "/favorites");
            },
          ),
          const Divider(),
          // Contact Number
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Contact Us"),
            subtitle: const Text("+1 234 567 890"),
            onTap: () {
              launchURL("tel:+1234567890");
            },
          ),
          const Divider(),
          // Social Media Links
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launchURL("https://facebook.com/NigiriStation");
                  },
                  child: Image.asset(
                    "assets/images/facebook.png", // Path to Facebook image
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchURL("https://tiktok.com/@nigiristation");
                  },
                  child: Image.asset(
                    "assets/images/tiktok.png",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchURL("https://instagram.com/nigiristation");
                  },
                  child: Image.asset(
                    "assets/images/instagram.png",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFBFFF1),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/logo2.png", height: 40.0),
      ),
      centerTitle: true,
      leading: Builder(
        builder:
            (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ), // Hamburger menu icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
