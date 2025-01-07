import 'package:flutter/material.dart';

class BottomNavigationButtons extends StatelessWidget {
  final VoidCallback onNext;

  BottomNavigationButtons({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, -2), blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          IconButton(
            icon: Icon(Icons.navigate_before, color: Colors.blueAccent),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 35,
          ),
          // Home button
          IconButton(
            icon: Icon(Icons.dashboard_sharp, color: Colors.blueAccent[700]),
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard'); // Adjust with your home page route
            },
            iconSize: 30,
          ),
          // Next button
          IconButton(
            icon: Icon(Icons.navigate_next, color: Colors.blueAccent),
            onPressed: onNext,
            iconSize: 35,
          ),
        ],
      ),
    );
  }
}
