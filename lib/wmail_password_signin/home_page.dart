// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/wmail_password_signin/email_password_signin_page.dart';
import 'package:flutter/material.dart';

class HomePagePage extends StatelessWidget {
  const HomePagePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email: ${user.email}",
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Text(
                "Name: ${user.displayName}",
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailPasswordSignInPage()),
                    );
                  } on FirebaseAuthException catch (e) {
                    final snackBar = SnackBar(
                      content: Text('${e.message}'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("LogOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
