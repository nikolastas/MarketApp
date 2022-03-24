import 'package:flutter/material.dart';
import 'package:market_app/details/colors.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

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
          icon: Container(
            decoration: BoxDecoration(
              color: primaryYellow,
              shape: BoxShape.circle,
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                  ),
                  iconSize: 40,
                )
                // Icon(
                //   Icons.add,
                // ),
                ),
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_grocery_store_outlined),
          label: 'Markets',
          backgroundColor: Colors.grey,
        ),
      ],
    );
  }
}
