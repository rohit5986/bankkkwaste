import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../data/wastec_bank_data.dart';
import '../widgets/profile_wallet_actions.dart';
import '../widgets/wallet_tab.dart';
import '../widgets/wastec_order_card.dart';
import 'home_clean.dart';

enum TrackOrderSource { wasteBank, ecoFriendly }

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key, this.source = TrackOrderSource.wasteBank});

  final TrackOrderSource source;

  @override
  Widget build(BuildContext context) {
    final orders = WastecBankData.orders;

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: WastecColors.primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.route_outlined, color: WastecColors.primaryGreen),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${orders.where((order) => (order['stage']! as int) < 5).length} active pickups in progress · '
                      'Stay updated with live journey checkpoints and driver contact details.',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...orders.map((order) => WastecOrderCard(order: order)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    if (source == TrackOrderSource.wasteBank) {
      // Show Waste Bank navbar: Home, Waste Bank, Track Order, Wallet
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
            // Navigate back to Waste Bank
            Navigator.of(context).pop();
          } else if (i == 2) {
            // Stay on Track Order
          } else if (i == 3) {
            // Navigate to Wallet Screen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const Scaffold(
                body: WalletTab(),
              )),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.recycling), label: 'Waste Bank'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: 'Track Order'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
        ],
      );
    } else {
      // Show Eco-Friendly navbar: Home, Eco-Friendly, Track Order, Wallet
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Eco-Friendly'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: 'Track Order'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
        ],
      );
    }
  }
}
