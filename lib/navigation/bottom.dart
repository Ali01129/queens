import 'package:flutter/material.dart';
import 'package:queens/screens/home.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Center(child: Text('Cart')),
    Center(child: Text('Messages')),
    Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color getIconColor(int index, bool darkMode) {
    if (_selectedIndex == index) {
      return darkMode ? Colors.white : Colors.black;
    } else {
      return Color(0xFF94979F);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Color(0xFF181e22) : Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: darkMode ? Colors.white : Colors.black,
          unselectedItemColor: Color(0xFF94979F),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, color: getIconColor(0, darkMode)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: getIconColor(1, darkMode)),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded, color: getIconColor(2, darkMode)),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, color: getIconColor(3, darkMode)),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}