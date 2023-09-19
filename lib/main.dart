import 'package:firebase_authentication/anonimus_signin/anonimus_sign_page.dart';
import 'package:firebase_authentication/google_signin/google_signin_page.dart';
import 'package:firebase_authentication/wmail_password_signin/email_password_signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoogleSignPage(),
    );
  }
}
