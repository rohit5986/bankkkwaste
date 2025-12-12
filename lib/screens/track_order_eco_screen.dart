import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../widgets/profile_wallet_actions.dart';
import 'home_clean.dart';

class TrackOrderEcoScreen extends StatelessWidget {
  const TrackOrderEcoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: WastecColors.primaryGreen,
        title: const Text(
          'Track Your Orders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [ProfileWalletActions()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: WastecColors.primaryGreen.withOpacity(0.5),
            ),
            const SizedBox(height: 20),
            Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your eco-friendly orders will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    // Eco-Friendly navbar: Home, Eco-Friendly, Track Order, Wallet
    return BottomNavigationBar(
      currentIndex: 2, // Track Order is at index 2
      selectedItemColor: WastecColors.primaryGreen,
      unselectedItemColor: WastecColors.mediumGray,
      onTap: (i) {
        if (i == 0) {
          // Navigate to Home Screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (i == 1) {
          // Navigate back to Eco-Friendly
          Navigator.of(context).pop();
        } else if (i == 2) {
          // Stay on Track Order
        } else if (i == 3) {
          // Navigate to Wallet - pop back to Eco-Friendly first
          Navigator.of(context).pop();
        }
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.arrow_back),
          activeIcon: const Icon(Icons.home_filled),
          label: 'Home',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Eco-Friendly'),
        const BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: 'Track Order'),
        const BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
      ],
    );
  }
}
