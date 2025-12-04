import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';

class ProfileWalletActions extends StatelessWidget {
  const ProfileWalletActions({super.key, this.iconColor = Colors.white});

  final Color iconColor;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: iconColor,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      );
}
