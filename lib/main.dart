import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodify/services/auth/auth_gate.dart';
import 'package:foodify/services/auth/login_or_register.dart';
import 'package:foodify/firebase_options.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:foodify/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBPgzCHzyCRf9B1uEPNH6gIxzL1Jx19vyg",
      appId: "1:285439902927:ios:6aad315b41e0f3eb1aa3ba",
      messagingSenderId: "285439902927",
      projectId: "foodify-a182a",
    ),
  );  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Restaurant(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
