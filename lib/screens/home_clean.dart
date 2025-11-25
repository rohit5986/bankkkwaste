import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../widgets/profile_wallet_actions.dart';
import '../widgets/wallet_tab.dart';
import 'eco_friendly_page.dart';
import 'sell_scrap_screen.dart';
import 'wastec_bank_screen.dart';
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
        return const _HomeTab();
      case 1:
        return const SellScrapScreen();
      case 2:
        return const _DealersTab();
      case 3:
        return const WalletTab();
      default:
        return const _HomeTab();
    }
  }

  PreferredSizeWidget _buildAppBar() {
    final titles = ['Wastec Bank', 'Sell Scrap', 'Dealers', 'Wallet'];
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

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: WastecColors.primaryGreen,
      unselectedItemColor: WastecColors.mediumGray,
      onTap: (i) {
        setState(() => _currentIndex = i);
      },
      type: BottomNavigationBarType.fixed,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.sell_outlined), label: 'Sell Scrap'),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_mall_directory_outlined), label: 'Dealers'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
        ],
    );
}

/// Home Tab Content
class _HomeTab extends StatelessWidget {
  const _HomeTab();

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
              destinationBuilder: (context) => const EcoFriendlyPage(),
            ),
            const SizedBox(height: 16),
            _HeroBanner(
              icon: Icons.recycling,
              title: 'Waste Bank',
              subtitle: 'Zero Garbage to Landfill',
              destinationBuilder: (context) => const WastecBankScreen(),
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
    required this.destinationBuilder,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final WidgetBuilder destinationBuilder;

  void _handleNavigation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: destinationBuilder),
    );
  }

  @override
  Widget build(BuildContext context) => Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _handleNavigation(context),
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
                onPressed: () => _handleNavigation(context),
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

/// Dealers Tab Placeholder
class _DealersTab extends StatelessWidget {
  const _DealersTab();

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_mall_directory, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Dealers',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
}

// Top feature cards were removed from Home — moved to Wastec Bank screen.

