import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_geolocation_test2/pages/logoanim.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
  ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyALDNpdn_cxSyRoAGUBzglk9Guorim-QZA",
        appId: "1:482126041881:android:f7848a6b1e89c437c52b88",
        messagingSenderId: "482126041881",
        projectId: "flutter-hosmngment"
    )
  )
 : await Firebase.initializeApp();
  FirebaseFirestore.instance.settings=const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ImageAnimationScreen(),
    );
  }
}
