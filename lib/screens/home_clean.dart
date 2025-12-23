import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../widgets/profile_wallet_actions.dart';
import '../widgets/wallet_tab.dart';
import '../widgets/location_header.dart';
import 'eco_friendly_page.dart';
import 'wastec_bank_screen.dart';
import 'track_order_screen.dart';
import 'track_order_eco_screen.dart';
// feature screens removed from Home; kept in Wastec Bank screen

/// Home screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  final int initialIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

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
        return EcoFriendlyPage(
          onNavigateToWasteBank: () => setState(() => _currentIndex = 2),
        );
      case 2:
        return WastecBankScreen(
          onNavigateToEcoFriendly: () => setState(() => _currentIndex = 1),
        );
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
    // For home (0), eco-friendly (1), and waste bank (2), show LocationHeader instead of title
    if (_currentIndex <= 2) {
      return AppBar(
        elevation: 0,
        backgroundColor: WastecColors.primaryGreen,
        title: const LocationHeader(),
        actions: const [ProfileWalletActions()],
      );
    }
    
    // For Wallet (3), show regular title
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
      return _buildCustomNavBar(
        selectedIndex: 1,
        showBackIcon: true,
        items: [
          _NavItem(icon: Icons.arrow_back, activeIcon: Icons.home_filled, label: 'Home'),
          _NavItem(icon: Icons.eco, label: 'Eco-Friendly'),
          _NavItem(icon: Icons.local_shipping_outlined, label: 'Track Order'),
          _NavItem(icon: Icons.account_balance_wallet_outlined, label: 'Wallet'),
        ],
        onTap: (i) {
          if (i == 0) {
            setState(() => _currentIndex = 0); // Home
          } else if (i == 1) {
            setState(() => _currentIndex = 1); // Eco-Friendly (stays on this tab)
          } else if (i == 2) {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const TrackOrderEcoScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (i == 3) {
            setState(() => _currentIndex = 3); // Wallet
          }
        },
      );
    }

    // When viewing Waste Bank (index 2), show a custom navbar with: Home, Waste Bank, Track Order, Wallet
    if (_currentIndex == 2) {
      return _buildCustomNavBar(
        selectedIndex: 1,
        showBackIcon: true,
        items: [
          _NavItem(icon: Icons.arrow_back, activeIcon: Icons.home_filled, label: 'Home'),
          _NavItem(icon: Icons.recycling, label: 'Waste Bank'),
          _NavItem(icon: Icons.local_shipping_outlined, label: 'Track Order'),
          _NavItem(icon: Icons.account_balance_wallet_outlined, label: 'Wallet'),
        ],
        onTap: (i) {
          if (i == 0) {
            setState(() => _currentIndex = 0); // Home
          } else if (i == 1) {
            setState(() => _currentIndex = 2); // Waste Bank (stays on this tab)
          } else if (i == 2) {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const TrackOrderScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (i == 3) {
            setState(() => _currentIndex = 3); // Wallet
          }
        },
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
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home_filled),
          label: 'Home',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Be Eco-Friendly'),
        const BottomNavigationBarItem(icon: Icon(Icons.recycling), label: 'Waste Bank'),
        const BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
      ],
    );
  }

  Widget _buildCustomNavBar({
    required int selectedIndex,
    required bool showBackIcon,
    required List<_NavItem> items,
    required Function(int) onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              // Home/Back button
              Expanded(
                child: InkWell(
                  onTap: () => onTap(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        showBackIcon ? items[0].icon : items[0].activeIcon,
                        color: selectedIndex == 0
                            ? WastecColors.primaryGreen
                            : WastecColors.mediumGray,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[0].label,
                        style: TextStyle(
                          fontSize: 11,
                          color: selectedIndex == 0
                              ? WastecColors.primaryGreen
                              : WastecColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Vertical divider after home button when showing back icon
              if (showBackIcon)
                Container(
                  width: 1,
                  height: 35,
                  color: Colors.grey.shade300,
                ),
              // Rest of the nav items
              ...List.generate(items.length - 1, (index) {
                final itemIndex = index + 1;
                final item = items[itemIndex];
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(itemIndex),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selectedIndex == itemIndex
                              ? (item.activeIcon ?? item.icon)
                              : item.icon,
                          color: selectedIndex == itemIndex
                              ? WastecColors.primaryGreen
                              : WastecColors.mediumGray,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            color: selectedIndex == itemIndex
                                ? WastecColors.primaryGreen
                                : WastecColors.mediumGray,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  _NavItem({required this.icon, this.activeIcon, required this.label});
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
      child: Column(
        children: [
          Expanded(
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
            const SizedBox(height: 24),
            // Thank you for recycling section
            _buildThankYouSection(),
            const SizedBox(height: 16),
            // CO2 Savings Card with Keep the streak section (combined)
            _buildCO2SavingsWithStreakCard(context),
            const SizedBox(height: 16),
            // Community impact card
            _buildCommunityImpactCard(),
            const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  Widget _buildThankYouSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Thank you for recycling ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: WastecColors.darkGray,
                      ),
                    ),
                    Text('🌱', style: TextStyle(fontSize: 20)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Every bag you send stops textile waste from hitting landfills.',
                  style: TextStyle(
                    fontSize: 14,
                    color: WastecColors.mediumGray,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.eco, color: WastecColors.primaryGreen, size: 28),
        ],
      ),
    );
  }

  Widget _buildCO2SavingsWithStreakCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top light green section - CO2 Savings
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: WastecColors.lightGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.show_chart, color: WastecColors.darkGreen, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'CO₂ Savings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: WastecColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.share, size: 16, color: WastecColors.darkGreen),
                          SizedBox(width: 4),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: WastecColors.darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  '0.00 kg',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: WastecColors.darkGreen,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'CO2 reduced by you',
                  style: TextStyle(
                    fontSize: 14,
                    color: WastecColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTag('Less landfill'),
                    _buildTag('Cleaner air'),
                    _buildTag('Circular fashion'),
                  ],
                ),
              ],
            ),
          ),
          // Bottom white section - Keep the streak
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: WastecColors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: WastecColors.lightGreen),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Keep the streak going!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: WastecColors.darkGray,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Every bag you recycle saves more CO2 emissions and helps us make reusable packaging from textiles. Let\'s do the next one?',
                  style: TextStyle(
                    fontSize: 14,
                    color: WastecColors.mediumGray,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: WastecColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Recycle More',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: WastecColors.primaryGreen.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: WastecColors.primaryGreen.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: WastecColors.darkGreen,
        ),
      ),
    );
  }

  Widget _buildCommunityImpactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: WastecColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WastecColors.lightGreen),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Wastec\'s community impact',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: WastecColors.darkGray,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Together, we have reduced:',
                      style: TextStyle(
                        fontSize: 14,
                        color: WastecColors.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: WastecColors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.tune, color: WastecColors.primaryGreen, size: 20),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.wb_sunny_outlined, color: WastecColors.accentAmber, size: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text(
                '16.94',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: WastecColors.primaryGreen,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'tonnes CO2',
                style: TextStyle(
                  fontSize: 16,
                  color: WastecColors.mediumGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.check_circle_outline, color: WastecColors.primaryGreen, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Clothes in wearable condition are donated to NGO, and the remaining ones are recycled.',
                  style: TextStyle(
                    fontSize: 14,
                    color: WastecColors.darkGray,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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

