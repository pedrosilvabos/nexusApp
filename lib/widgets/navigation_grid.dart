import 'package:flutter/material.dart';

class NavigationGrid extends StatelessWidget {
  const NavigationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for navigation items
    final List<Map<String, dynamic>> navigationItems = [
      {
        'icon': Icons.museum,
        'label': 'Museums',
        'details': '6 locations · 3 km away',
      },
      {
        'icon': Icons.restaurant,
        'label': 'Restaurants',
        'details': '12 options · 1.5 km away',
      },
      {
        'icon': Icons.shopping_bag,
        'label': 'Gift Shops',
        'details': '8 shops · 2.8 km away',
      },
      {
        'icon': Icons.map,
        'label': 'Activities',
        'details': '4 activities · 5 km away',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabButton(label: "Discover", isSelected: true),
              _buildTabButton(label: "Favorites", isSelected: false),
              _buildTabButton(label: "My Activities", isSelected: false),
            ],
          ),
          const SizedBox(height: 16),
          // Wrap the GridView in Expanded to prevent overflow
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 items per row
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio:
                    0.5, // Adjust this ratio for better height fit
              ),
              itemCount: navigationItems.length,
              itemBuilder: (context, index) {
                final item = navigationItems[index];
                return _buildNavigationItem(
                  icon: item['icon'] as IconData,
                  label: item['label'] as String,
                  details: item['details'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Builds a single navigation tile
  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required String details,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 32, // Adjust radius to prevent overflow
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue, size: 42),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          details,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Builds a single tab button
  Widget _buildTabButton({required String label, required bool isSelected}) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}
