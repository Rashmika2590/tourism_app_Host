import 'package:flutter/material.dart';

class BottomNavigationButtons extends StatelessWidget {
  //final VoidCallback onPrevious; // Function to call when Previous is tapped
//final VoidCallback onHome; // Function to call when Home is tapped
  final VoidCallback onNext; // Function to call when Next is tapped

  BottomNavigationButtons({
    //required this.onPrevious,
    //required this.onHome,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)), // Rounded corners
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset(0, -2), blurRadius: 6), // Subtle shadow
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous button with attractive icon
            IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.blueAccent),
              onPressed: () {
                  // Handle previous navigation
                  Navigator.pop(context); 
              },
              iconSize: 35, // Slightly smaller icon size for a compact look
            ),
            // Home button - Centered with a larger, attractive icon
            IconButton(
              icon: Icon(Icons.dashboard_sharp, color: Colors.blueAccent[700]),
              onPressed:(){
                  // Navigate to the home page
                  Navigator.pushNamed(context, '/dashboard'); // Replace with your actual home page route
                },
              iconSize: 30, // Slightly larger icon for the center
            ),
            // Next button with attractive icon
            IconButton(
              icon: Icon(Icons.navigate_next, color: Colors.blueAccent),
              onPressed: onNext,
              iconSize: 35, // Slightly smaller icon size for a compact look
            ),
          ],
        ),
      ),
    );
  }
}
