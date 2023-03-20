import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projek_pertama/pages/home_pages.dart';
import 'package:projek_pertama/pages/profile_page.dart';
import 'package:projek_pertama/pages/shop_page.dart';
import 'package:projek_pertama/screen/homeScreen.dart';
import 'package:projek_pertama/screen/ticketScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedItem = 0;
  GlobalKey<CurvedNavigationBarState> _globalKey = GlobalKey();
  final List<Map<String, dynamic>> _page = [
    {'page': const HomePage(), 'title': 'Beranda'},
    {'page': const ShopPage(), 'title': 'Shop'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedItem,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey.shade500,
        type: BottomNavigationBarType.fixed,
      ),
      body: _page[_selectedItem]['page'],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }
}
