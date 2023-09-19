import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/google_signin/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignPage extends StatelessWidget {
  const GoogleSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login With Google"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Login With Google in Button Google",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () async {
                  try {
                    GoogleSignInAccount? account =
                        await GoogleSignIn().signIn();
                    log("IDTOKEN: ${account}");
                    if (account != null) {
                      GoogleSignInAuthentication auth =
                          await account.authentication;

                      AuthCredential credential = GoogleAuthProvider.credential(
                        idToken: auth.idToken,
                        accessToken: auth.accessToken,
                      );
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage(
                                  user: FirebaseAuth.instance.currentUser!,
                                  accesToken: auth.accessToken!,
                                  idToken: auth.idToken!,
                                )),
                      );
                    }
                  } catch (e) {
                    final snackBar = SnackBar(
                      content: Text('$e'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    log(e.toString());
                  }
                },
                child: const Text("Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
