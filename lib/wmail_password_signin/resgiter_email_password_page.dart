import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/wmail_password_signin/email_password_signin_page.dart';
import 'package:flutter/material.dart';

class RegisterEmailPasswordPage extends StatelessWidget {
  RegisterEmailPasswordPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Halaman Register",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: 'Enter your email address',
                ),
                controller: emailController,
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: Icon(
                    Icons.password,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: 'Enter your password',
                ),
                controller: passwordController,
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailPasswordSignInPage()),
                    );
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.message.toString(),
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
