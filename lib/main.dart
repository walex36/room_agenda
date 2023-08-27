import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    await GoogleSignIn().disconnect();
  }
  await FirebaseAuth.instance.signOut();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);

  runApp(const AppWidget());
}
