import 'package:flutter/material.dart';
import 'package:tourist_app/screens/attraction_map_screen.dart';
import 'package:tourist_app/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: const Text('Tourist App'),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MapScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
