import 'package:flutter/material.dart';
import 'package:market_app/details/colors.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);
  final int currentIndex;
  final Function(int) onTap;
  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: primaryWhite,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Items',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_grocery_store_outlined),
          label: 'Markets',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(
                  color: primaryYellow,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                  ),
                )
                // Icon(
                //   Icons.add,
                // ),

                ),
            label: "Add Item"),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.support_agent),
          label: 'Support',
          backgroundColor: Colors.grey,
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
    );
  }
}
