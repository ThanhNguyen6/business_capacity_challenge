import 'package:flutter/material.dart';
import 'package:opun_challenge/screens/home_screen.dart';
import 'package:opun_challenge/screens/settings_screen.dart';
import 'package:opun_challenge/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'core/models/businessInfo.dart';
import 'core/viewmodels/CRUDModel.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<CRUDModel>()),
        ChangeNotifierProvider(create: (_) => Business()),
      ],
      child: MaterialApp(
        title: 'Capacity Counter',
        routes: {
          // default route:
          '/': (context) => WelcomeScreen(),
          '/home': (context) => MyHomePage(title: "Capacity Counter"),
          '/settings': (context) => SettingsScreen(),
        },
      ) //Material App
    );
  }
}


