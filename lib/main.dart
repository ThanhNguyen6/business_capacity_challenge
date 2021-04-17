import 'package:flutter/material.dart';
import 'package:opun_challenge/screens/home_screen.dart';

import 'package:opun_challenge/screens/settings_screen.dart';
import 'package:opun_challenge/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyAwesomeApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }


}

class MyAwesomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capacity Counter',
      routes: {
        // default route:
        '/': (context) => WelcomeScreen(),
        '/home': (context) => MyHomePage(title: 'Capacity Counter'),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
