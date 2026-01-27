import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_expense_wallet/screens/hello_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebase doit être initialisé
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Expense Wallet',
      theme: ThemeData(
        primaryColor: const Color(0xFF76A82F),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF76A82F)),
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloScreen(),
    );
  }
}