import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BotNavbar extends StatelessWidget {
   final int currentIndex;
  final Function(int) onTap;

  const BotNavbar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const <Widget>[
        Icon(CupertinoIcons.house, size: 30, color: Colors.blueAccent),
        Icon(CupertinoIcons.heart_fill, size: 30, color: Colors.blueAccent),
        Icon(CupertinoIcons.profile_circled, size: 30, color: Colors.blueAccent),
      ],
      // color: Color.fromARGB(255, 255, 255, 255),
      // buttonBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      // backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 1000),
      onTap: onTap,
      letIndexChange: (index) => true,
      index: currentIndex,
      // letIndexChange: (index) => true,
    );
  }
}
