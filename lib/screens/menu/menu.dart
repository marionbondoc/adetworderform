import 'package:flutter/material.dart';
import 'package:practiceapp/screens/navbars/botbar.dart';
import 'package:practiceapp/screens/navbars/topbar.dart';

import 'package:practiceapp/screens/menu/body.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      drawer: TopBar.buildDrawer(context), // Use the Drawer from TopBar
      body: const MenuBody(),
      bottomNavigationBar: BotBar(),
    );
  }
}
