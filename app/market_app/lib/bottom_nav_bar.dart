import 'colors.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onClicked;
  const BottomMenu(
      {Key? key, required this.selectedIndex, required this.onClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: 'Items',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Markets',
          backgroundColor: Colors.grey,
        ),
        
      ],
      currentIndex: selectedIndex,
      selectedItemColor: primaryBlue,
      onTap: onClicked,
    );
  }
}
