import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_expense_wallet/services/auth_service.dart';
import 'package:smart_expense_wallet/screens/home/home.dart';
import 'package:smart_expense_wallet/screens/welcome/welcomeScreen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // If the snapshot has user data, the user is logged in
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Otherwise, they are not logged in
        return const WelcomeScreen();
      },
    );
  }
}
