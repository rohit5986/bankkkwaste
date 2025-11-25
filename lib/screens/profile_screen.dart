import 'package:flutter/material.dart';
import '../config/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static final List<_ProfileOption> _options = [
    _ProfileOption(
      title: 'My Orders / Scrap History',
      icon: Icons.history,
      builder: (_) => const MyOrdersPage(),
    ),
    _ProfileOption(
      title: 'Track My Orders',
      icon: Icons.local_shipping,
      builder: (_) => const TrackOrdersPage(),
    ),
    _ProfileOption(
      title: 'Reward Points',
      icon: Icons.star,
      builder: (_) => const RewardsPage(),
    ),
    _ProfileOption(
      title: 'My Addresses',
      icon: Icons.location_on,
      builder: (_) => const ComingSoonPage(title: 'My Addresses'),
    ),
    _ProfileOption(
      title: 'Payment Methods',
      icon: Icons.payment,
      builder: (_) => const ComingSoonPage(title: 'Payment Methods'),
    ),
    _ProfileOption(
      title: 'Notifications',
      icon: Icons.notifications,
      builder: (_) => const ComingSoonPage(title: 'Notifications'),
    ),
    _ProfileOption(
      title: 'Refer & Earn',
      icon: Icons.person_add,
      builder: (_) => const ComingSoonPage(title: 'Refer & Earn'),
    ),
    _ProfileOption(
      title: 'Contact Support',
      icon: Icons.support_agent,
      builder: (_) => const ComingSoonPage(title: 'Contact Support'),
    ),
    _ProfileOption(
      title: 'About Wastec Bank',
      icon: Icons.info_outline,
      builder: (_) => const ComingSoonPage(title: 'About Wastec Bank'),
    ),
    _ProfileOption(
      title: 'Settings',
      icon: Icons.settings,
      builder: (_) => const SettingsPage(),
    ),
    const _ProfileOption(
      title: 'Log Out',
      icon: Icons.logout,
      isLogout: true,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: WastecColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor:
                            WastecColors.primaryGreen.withOpacity(0.12),
                        child: const Icon(
                          Icons.person,
                          size: 36,
                          color: WastecColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello, Subodh!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'subodh@example.com',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () => _openPage(
                                context,
                                (_) => const EditProfilePage(),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: WastecColors.primaryGreen,
                                side: const BorderSide(
                                  color: WastecColors.primaryGreen,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Edit Profile'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildStatsSection(),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: List.generate(_options.length, (index) {
                    final option = _options[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            option.icon,
                            color: option.isLogout
                                ? Colors.red
                                : WastecColors.primaryGreen,
                          ),
                          title: Text(option.title),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _handleOptionTap(context, option),
                        ),
                        if (index < _options.length - 1)
                          const Divider(height: 1, indent: 16, endIndent: 16),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Wastec Bank • Helping you recycle smarter',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  Widget _buildStatsSection() {
    final stats = [
      ('₹ Earned', '₹2,450', Icons.currency_rupee),
      ('Weight Recycled', '52 kg', Icons.recycling),
      ('Eco Points', '120', Icons.star),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 480;
        if (isCompact) {
          return Column(
            children: [
              for (var i = 0; i < stats.length; i++)
                Padding(
                  padding:
                      EdgeInsets.only(bottom: i == stats.length - 1 ? 0 : 12),
                  child: _StatCard(
                    label: stats[i].$1,
                    value: stats[i].$2,
                    icon: stats[i].$3,
                  ),
                ),
            ],
          );
        }

        return Row(
          children: [
            for (var i = 0; i < stats.length; i++)
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: i == stats.length - 1 ? 0 : 12),
                  child: _StatCard(
                    label: stats[i].$1,
                    value: stats[i].$2,
                    icon: stats[i].$3,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _handleOptionTap(BuildContext context, _ProfileOption option) {
    if (option.isLogout) {
      _showLogoutDialog(context);
    } else if (option.builder != null) {
      _openPage(context, option.builder!);
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully.')),
                );
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
    );
  }

  void _openPage(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: WastecColors.primaryGreen, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
}

class _ProfileOption {
  const _ProfileOption({
    required this.title,
    required this.icon,
    this.builder,
    this.isLogout = false,
  });

  final String title;
  final IconData icon;
  final WidgetBuilder? builder;
  final bool isLogout;
}

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#WSTC001',
        'date': '09 Nov 2025',
        'status': 'Completed',
        'amount': '₹320'
      },
      {
        'id': '#WSTC002',
        'date': '06 Nov 2025',
        'status': 'Completed',
        'amount': '₹540'
      },
      {
        'id': '#WSTC003',
        'date': '02 Nov 2025',
        'status': 'In Progress',
        'amount': '₹180'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: WastecColors.primaryGreen,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: WastecColors.primaryGreen.withOpacity(0.15),
                child: const Icon(Icons.recycling, color: Colors.green),
              ),
              title: Text('Order ${order['id']}'),
              subtitle: Text('${order['date']} • ${order['status']}'),
              trailing: Text(
                order['amount']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class TrackOrdersPage extends StatelessWidget {
  const TrackOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'title': 'Pickup Scheduled', 'subtitle': 'Pickup on 12 Nov, 10:00 AM'},
      {'title': 'Rider Assigned', 'subtitle': 'Rahul (8823-XX-XXXX)'},
      {'title': 'Pickup In Progress', 'subtitle': 'Rider is on the way'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track My Orders'),
        backgroundColor: WastecColors.primaryGreen,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: WastecColors.primaryGreen.withOpacity(0.15),
                  child: Icon(
                    index == steps.length - 1
                        ? Icons.directions_bike
                        : Icons.check,
                    color: WastecColors.primaryGreen,
                  ),
                ),
                title: Text(step['title']!),
                subtitle: Text(step['subtitle']!),
              ),
              if (index < steps.length - 1)
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Container(
                    height: 24,
                    width: 2,
                    color: WastecColors.primaryGreen.withOpacity(0.2),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
        backgroundColor: WastecColors.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: WastecColors.primaryGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eco Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '120 Points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Redeem your Eco Points for discounts on pickup charges and partner stores.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Rewards',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  const rewardTitles = [
                    'Pickup Bonus',
                    'Referral Bonus',
                    'Plastic Drive'
                  ];
                  const rewardPoints = ['+20 pts', '+50 pts', '+10 pts'];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            WastecColors.primaryGreen.withOpacity(0.15),
                        child: const Icon(Icons.card_giftcard,
                            color: Colors.green),
                      ),
                      title: Text(rewardTitles[index]),
                      subtitle: const Text('Earned on 08 Nov 2025'),
                      trailing: Text(rewardPoints[index],
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: WastecColors.primaryGreen,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
            title: const Text('Dark Mode'),
            subtitle: const Text('Reduce glare and save battery'),
            activeThumbColor: WastecColors.primaryGreen,
          ),
          const Divider(),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final selected = await showModalBottomSheet<String>(
                context: context,
                builder: (sheetContext) {
                  final languages = ['English', 'Hindi', 'Marathi'];
                  return SafeArea(
                    child: ListView(
                      children: languages
                          .map(
                            (language) => ListTile(
                              title: Text(language),
                              trailing: language == _language
                                  ? const Icon(Icons.check,
                                      color: WastecColors.primaryGreen)
                                  : null,
                              onTap: () =>
                                  Navigator.pop(sheetContext, language),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              );

              if (selected != null && mounted) {
                setState(() => _language = selected);
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications_active),
            title: const Text('Push Notifications'),
            subtitle: const Text('Manage waste pickup reminders'),
            onTap: () {},
          ),
        ],
      ),
    );
}

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: WastecColors.primaryGreen,
      ),
      body: Center(
        child: Text(
          '$title\nComing Soon',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: WastecColors.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: WastecColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
}
