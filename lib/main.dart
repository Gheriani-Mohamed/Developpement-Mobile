import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_expense_wallet/theme/app_theme.dart';
import 'package:smart_expense_wallet/theme/theme_provider.dart';
import 'package:smart_expense_wallet/views/splash/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'SmartWallet',
          debugShowCheckedModeBanner: false,
          theme: SmartWalletTheme.lightTheme,
          darkTheme: SmartWalletTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
