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
  DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('businessInfo').doc('test').get();
  Business businessInfo = Business.fromMap(snapshot.data(), 'test');
  runApp(MyApp(businessInfo));
}

class MyApp extends StatelessWidget {
  final Business bInfo;
  MyApp(this.bInfo);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<CRUDModel>()),
      ],
      child: MaterialApp(
        title: 'Capacity Counter',
        routes: {
          // default route:
          '/': (context) => WelcomeScreen(title: bInfo.name),
          '/home': (context) => MyHomePage(title: bInfo.name),
          '/settings': (context) => SettingsScreen(bInfo: bInfo),
        },
      ) //Material App
    );
  }
}


