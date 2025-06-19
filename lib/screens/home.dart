import 'package:flutter/material.dart';
import 'event_list.dart';
import 'map_screen.dart';
import 'add_event.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final screens = [
    EventListScreen(),
    MapScreen(),
    AddEventScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.black,
        indicatorColor: Colors.purpleAccent.withOpacity(0.1),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: [
          NavigationDestination(icon: Icon(Icons.list), label: 'События'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Карта'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Добавить'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
