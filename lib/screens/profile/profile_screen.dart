import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:smart_expense_wallet/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_expense_wallet/theme/app_theme.dart';
import 'package:smart_expense_wallet/screens/auth/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          _buildHeader(theme, textColor),
          const SizedBox(height: 32),
          _buildHasStats(theme),
          const SizedBox(height: 32),
          _buildSettingsMenu(context, theme, textColor),
          const SizedBox(height: 48),
          _buildLogoutButton(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, Color textColor) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'User';
    final email = user?.email ?? 'No Email';

    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: SmartWalletTheme.primaryColor,
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                backgroundColor: Colors.grey,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SmartWalletTheme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  LucideIcons.camera,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          displayName,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildHasStats(ThemeData theme) {
    return Row(
      children: [
        _buildStatCard(theme, '03', 'Wallets'),
        const SizedBox(width: 16),
        _buildStatCard(theme, '05', 'Budgets'),
        const SizedBox(width: 16),
        _buildStatCard(theme, '02', 'Goals'),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: SmartWalletTheme.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenu(
    BuildContext context,
    ThemeData theme,
    Color textColor,
  ) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          theme,
          textColor,
          LucideIcons.user,
          'Personal Information',
          'Edit Name, Email',
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          context,
          theme,
          textColor,
          LucideIcons.wallet,
          'Manage Wallets',
          'Add or remove wallets',
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          context,
          theme,
          textColor,
          LucideIcons.shield,
          'Security',
          'Password, Biometrics',
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          context,
          theme,
          textColor,
          LucideIcons.helpCircle,
          'Help & Support',
          'FAQ, Contact Us',
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    ThemeData theme,
    Color textColor,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardColor, // Uses theme card color (White/Slate-800)
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: SmartWalletTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: SmartWalletTheme.primaryColor, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 14),
        ),
        trailing: Icon(
          LucideIcons.chevronRight,
          color: textColor.withOpacity(0.3),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final authService = AuthService();
        await authService.logout();
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      icon: const Icon(LucideIcons.logOut, color: Colors.redAccent),
      label: const Text(
        'Sign Out',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    );
  }
}
