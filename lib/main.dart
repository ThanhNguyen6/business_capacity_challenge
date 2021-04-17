import 'package:flutter/material.dart';
import 'package:opun_challenge/screens/home_screen.dart';

import 'package:opun_challenge/screens/settings_screen.dart';
import 'package:opun_challenge/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'locator.dart';

void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
      ],
        child: MaterialApp(
          title: 'Capacity Counter',
          routes: {
            // default route:
            '/': (context) => WelcomeScreen(),
            '/home': (context) => MyHomePage(title: 'Capacity Counter'),
            '/settings': (context) => SettingsScreen(),
          }, //route
        )// MaterialApp
    ); //multiprovider
  }//widget
}
