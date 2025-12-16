import 'package:flutter/material.dart';
import '../config/theme.dart';

enum QuickNavTarget { wasteBank, ecoFriendly }

class QuickAccessRow extends StatelessWidget {
  const QuickAccessRow({
    required this.current,
    required this.onNavigateToWasteBank,
    required this.onNavigateToEcoFriendly,
    super.key,
  });

  final QuickNavTarget current;
  final VoidCallback? onNavigateToWasteBank;
  final VoidCallback? onNavigateToEcoFriendly;

  @override
  Widget build(BuildContext context) => Container(
        color: WastecColors.primaryGreen,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
        child: Row(
          children: [
            QuickNavPill(
              label: 'Waste Bank',
              icon: Icons.recycling,
              isActive: current == QuickNavTarget.wasteBank,
              onTap: current == QuickNavTarget.wasteBank ? null : onNavigateToWasteBank,
            ),
            const SizedBox(width: 12),
            QuickNavPill(
              label: 'Be Eco-Friendly',
              icon: Icons.eco_outlined,
              isActive: current == QuickNavTarget.ecoFriendly,
              onTap: current == QuickNavTarget.ecoFriendly ? null : onNavigateToEcoFriendly,
            ),
          ],
        ),
      );
}

class QuickNavPill extends StatelessWidget {
  const QuickNavPill({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isActive ? WastecColors.white : WastecColors.primaryGreen;
    final foregroundColor = isActive ? WastecColors.primaryGreen : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
            bottom: Radius.zero,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: foregroundColor, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
