import 'package:flutter/material.dart';

// Custom BottomNavigation Bar widget
class CustomBottomNavBar extends StatelessWidget {
  final void Function() onCenterButtonPressed;

  const CustomBottomNavBar({Key? key, required this.onCenterButtonPressed})
      : super(key: key);

  // Define the colors
  final greenBlue = const Color(0xFF88C0D0);
  final arcticBlue = const Color(0xFFB0C4DE);
  final pearlWhite = const Color(0xFFF8F8FF); // Pearl White color
  final darkerArcticBlue = const Color(0xFF79B0EF);

  // Helper method to build the individual tab items
  Widget _buildTabItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 28,
        ),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }

  // Helper method for the center button
  Widget _buildCenterButton(IconData icon, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: arcticBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 38),
        onPressed: onCenterButtonPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            arcticBlue, // Custom Arctic Blue
            Theme.of(context)
                .scaffoldBackgroundColor, // System background color
          ],
          begin: Alignment.topCenter, // Start the gradient from the top
          end: Alignment.bottomCenter, // End the gradient at the bottom
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(Icons.map, 'Discover'),
          _buildTabItem(Icons.local_offer, 'Deals'),
          _buildCenterButton(Icons.add, context),
          _buildTabItem(Icons.notifications, 'Alerts'),
          _buildTabItem(Icons.person, 'Profile'),
        ],
      ),
    );
  }
}
