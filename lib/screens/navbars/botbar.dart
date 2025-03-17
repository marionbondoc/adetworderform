import 'package:flutter/material.dart';

class BotBar extends StatelessWidget {
  const BotBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFBFFF1),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/onigiri.png", height: 24.0),
          label: "Menu",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/menu.png", height: 24.0),
          label: "Orders",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/favorite.png", height: 24.0),
          label: "Favorites",
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "/menu");
            break;
          case 1:
            Navigator.pushNamed(context, "/cart");
            break;
          case 2:
            Navigator.pushNamed(context, "/favorites");
            break;
        }
      },
    );
  }
}
