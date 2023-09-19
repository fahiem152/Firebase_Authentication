import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AnonimusSignPage extends StatelessWidget {
  const AnonimusSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In Anonimus",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "USer: ${snapshot.data?.uid}",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      );
                    } else {
                      return const Text(
                        "Please Sign In",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    FirebaseAuth.instance.signOut();
                  } else {
                    FirebaseAuth.instance.signInAnonymously();
                  }
                },
                child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.userChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const Text("Sign Out");
                      } else {
                        return const Text("Sign In");
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
