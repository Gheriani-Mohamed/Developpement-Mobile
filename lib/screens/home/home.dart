import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:smart_expense_wallet/theme/app_theme.dart';
import 'package:smart_expense_wallet/theme/theme_provider.dart';
import 'package:smart_expense_wallet/views/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedWalletIndex = 0;
  final List<String> _wallets = ['Personal', 'Family', 'Company'];

  // Dummy data
  final String _balance = "\$12,850.00";
  final String _income = "\$4,250";
  final String _expenses = "\$1,200";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    final List<Widget> pages = [
      _buildDashboard(context, theme, textColor),
      const Center(child: Text("Wallets Feature Coming Soon")),
      const Center(child: Text("Stats Feature Coming Soon")),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: SmartWalletTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color:
            theme.bottomAppBarTheme.color ??
            (theme.brightness == Brightness.dark
                ? const Color(0xFF1E293B)
                : Colors.white),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(LucideIcons.home, 0),
              _buildNavItem(LucideIcons.wallet, 1),
              const SizedBox(width: 48), // Spacer for FAB
              _buildNavItem(LucideIcons.pieChart, 2),
              _buildNavItem(LucideIcons.user, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return IconButton(
      onPressed: () => setState(() => _selectedIndex = index),
      icon: Icon(
        icon,
        color: isSelected ? SmartWalletTheme.primaryColor : Colors.grey,
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    ThemeData theme,
    Color textColor,
  ) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, textColor),
            const SizedBox(height: 24),
            _buildWalletSelector(),
            const SizedBox(height: 24),
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildQuickActions(textColor),
            const SizedBox(height: 32),
            _buildTransactionList(textColor),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color textColor) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/300',
          ), // Replace with local asset if needed
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              'John Doe',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        // Theme Toggle
        Container(
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? LucideIcons.sun
                  : LucideIcons.moon,
              size: 20,
              color: textColor,
            ),
            onPressed: () {
              final provider = Provider.of<ThemeProvider>(
                context,
                listen: false,
              );
              provider.toggleTheme(!provider.isDarkMode);
            },
          ),
        ),
        const SizedBox(width: 8),
        // Notifications
        Container(
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(LucideIcons.bell, size: 20, color: textColor),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildWalletSelector() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _wallets.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = _selectedWalletIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedWalletIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF0F172A)
                    : Colors.transparent, // Dark for selected
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  _wallets[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF76A82F), // Primary Green
            Color(0xFF5C8424), // Dark Green
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF76A82F).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Glassmorphism effects
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_wallets[_selectedWalletIndex]} Wallet',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      LucideIcons.creditCard,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  _balance,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildBalanceItem('Income', _income, LucideIcons.arrowUp),
                    const SizedBox(width: 40),
                    _buildBalanceItem(
                      'Expenses',
                      _expenses,
                      LucideIcons.arrowDown,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String amount, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 12),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionItem(LucideIcons.send, 'Send', textColor),
        _buildActionItem(LucideIcons.download, 'Receive', textColor),
        _buildActionItem(LucideIcons.barChart2, 'Stats', textColor),
        _buildActionItem(LucideIcons.moreHorizontal, 'More', textColor),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color textColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: SmartWalletTheme.primaryColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(Color textColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  color: SmartWalletTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Dummy List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return _buildTransactionItem(
              icon: [
                LucideIcons.shoppingBag,
                LucideIcons.car,
                LucideIcons.coffee,
              ][index],
              color: [Colors.orange, Colors.blue, Colors.brown][index],
              title: ['Grocery Store', 'Uber Ride', 'Starbucks'][index],
              subtitle: ['Food', 'Transport', 'Coffee'][index],
              amount: ['-\$45.00', '-\$12.50', '-\$5.40'][index],
              textColor: textColor,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String amount,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
