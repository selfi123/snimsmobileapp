import 'package:flutter_geolocation_test2/pages/dutytime.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_geolocation_test2/pages/signuppage.dart';



class ImageAnimationScreen extends StatefulWidget {
  @override
  State<ImageAnimationScreen> createState() => _ImageAnimationScreenState();
}

class _ImageAnimationScreenState extends State<ImageAnimationScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? _opacityAnimation;
  AnimationController? _animationController;
  late final String _imagePath; // Replace with your image path

  @override
  void initState() {
    super.initState();
    _imagePath = "assets/snims.png";
    _animationController = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_animationController!);

    Timer(Duration(seconds: 1), () {
      _animationController!.forward();
    });
  }


  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
  void navigateToLoginPage(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()),

    );
  }
   Future<bool> isUserLoggedIn() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user != null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter, // Position button at the bottom
          children: [
            FadeTransition(
              opacity: _opacityAnimation!,
              child: Image.asset(
                _imagePath, // Use the correct image path variable
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Replace with your login check logic and navigation
                if (await isUserLoggedIn()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DutyTime()),
                  );
                } else {
                  navigateToLoginPage();
                }
              },
              child: const Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }

}
