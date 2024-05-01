import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
   User? get currentuser => _firebaseAuth.currentUser;
   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
   Future<void> signInWithEmailAndPassword({
    required String email,
     required String password,
     //required String staffid,
     }) async{
     await _firebaseAuth.signInWithEmailAndPassword(
         email: email,
         password: password,
        //staffid: staffid,
     );
   }
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    //required String staffid,
  }) async{
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        //staffid: staffid,
    );
  }
  Future<void>signOut() async{
     await _firebaseAuth.signOut();

  }
}