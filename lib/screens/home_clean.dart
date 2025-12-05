import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../widgets/profile_wallet_actions.dart';
import '../widgets/wallet_tab.dart';
import 'eco_friendly_page.dart';
import 'wastec_bank_screen.dart';
import 'track_order_screen.dart';
// feature screens removed from Home; kept in Wastec Bank screen

/// Home screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: WastecColors.white,
      appBar: _buildAppBar(),
      body: _getBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return _HomeTab(
          onNavigateToEcoFriendly: () => setState(() => _currentIndex = 1),
          onNavigateToWasteBank: () => setState(() => _currentIndex = 2),
        );
      case 1:
        return const EcoFriendlyPage();
      case 2:
        return const WastecBankScreen();
      case 3:
        return const WalletTab();
      default:
        return _HomeTab(
          onNavigateToEcoFriendly: () => setState(() => _currentIndex = 1),
          onNavigateToWasteBank: () => setState(() => _currentIndex = 2),
        );
    }
  }

  PreferredSizeWidget _buildAppBar() {
    final titles = ['Wastec Bank', 'Be Eco-Friendly', 'Waste Bank', 'Wallet'];
    return AppBar(
      elevation: 0,
      backgroundColor: WastecColors.primaryGreen,
      title: Text(
        titles[_currentIndex],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: const [ProfileWalletActions()],
    );
  }

  Widget _buildBottomNavigationBar() {
    // When viewing Eco-Friendly (index 1), show a custom navbar with: Home, Eco-Friendly, Track Order, Wallet
    if (_currentIndex == 1) {
      return BottomNavigationBar(
        currentIndex: 1, // Eco-Friendly is at index 1 in this contextual bar
        selectedItemColor: WastecColors.primaryGreen,
        unselectedItemColor: WastecColors.mediumGray,
        onTap: (i) {
          if (i == 0) {
            setState(() => _currentIndex = 0); // Home
          } else if (i == 1) {
            setState(() => _currentIndex = 1); // Eco-Friendly (stays on this tab)
          } else if (i == 2) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TrackOrderScreen(source: TrackOrderSource.ecoFriendly)));
          } else if (i == 3) {
            setState(() => _currentIndex = 3); // Wallet
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

    // When viewing Waste Bank (index 2), show a custom navbar with: Home, Waste Bank, Track Order, Wallet
    if (_currentIndex == 2) {
      return BottomNavigationBar(
        currentIndex: 1, // Waste Bank is at index 1 in this contextual bar
        selectedItemColor: WastecColors.primaryGreen,
        unselectedItemColor: WastecColors.mediumGray,
        onTap: (i) {
          if (i == 0) {
            setState(() => _currentIndex = 0); // Home
          } else if (i == 1) {
            setState(() => _currentIndex = 2); // Waste Bank (stays on this tab)
          } else if (i == 2) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TrackOrderScreen(source: TrackOrderSource.wasteBank)));
          } else if (i == 3) {
            setState(() => _currentIndex = 3); // Wallet
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
    }

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: WastecColors.primaryGreen,
      unselectedItemColor: WastecColors.mediumGray,
      onTap: (i) {
        setState(() => _currentIndex = i);
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Be Eco-Friendly'),
        BottomNavigationBarItem(icon: Icon(Icons.recycling), label: 'Waste Bank'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
      ],
    );
  }
}

/// Home Tab Content
class _HomeTab extends StatelessWidget {
  const _HomeTab({
    this.onNavigateToEcoFriendly,
    this.onNavigateToWasteBank,
  });

  final VoidCallback? onNavigateToEcoFriendly;
  final VoidCallback? onNavigateToWasteBank;

  @override
  Widget build(BuildContext context) => SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroBanner(
              icon: Icons.eco,
              title: 'Be Eco-Friendly',
              subtitle: 'Turn your waste into wealth while saving the planet',
              onTap: onNavigateToEcoFriendly,
            ),
            const SizedBox(height: 16),
            _HeroBanner(
              icon: Icons.recycling,
              title: 'Waste Bank',
              subtitle: 'Zero Garbage to Landfill',
              onTap: onNavigateToWasteBank,
            ),
          ],
        ),
      ),
    );
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                WastecColors.primaryGreen,
                WastecColors.primaryGreen.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: WastecColors.primaryGreen.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 48, color: Colors.white.withOpacity(0.9)),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.95),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: WastecColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Open Now',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

}

// Top feature cards were removed from Home — moved to Wastec Bank screen.

