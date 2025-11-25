import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../data/wastec_bank_data.dart';
import '../widgets/wastec_order_card.dart';
import '../widgets/profile_wallet_actions.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

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
    );
  }
}
