import 'package:flutter_geolocation_test2/auth.dart';
import 'package:flutter_geolocation_test2/pages/home.dart';
import 'package:flutter_geolocation_test2/pages/signinpage.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Auth().authStateChanges,
        builder: (context,snapshot){
      if (snapshot.hasData){
        return HomePage();

      }
      else{
        return const SignInPage();
      }
        });
  }
}
