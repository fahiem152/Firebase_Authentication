import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/wmail_password_signin/forgot_password_page.dart';
import 'package:firebase_authentication/wmail_password_signin/home_page.dart';
import 'package:firebase_authentication/wmail_password_signin/resgiter_email_password_page.dart';
import 'package:flutter/material.dart';

class EmailPasswordSignInPage extends StatelessWidget {
  EmailPasswordSignInPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIgnIn Email and Password"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Halaman Login",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterEmailPasswordPage()),
                ),
                child: const Text(
                  "Register Here",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    User? user = FirebaseAuth.instance.currentUser;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePagePage(
                                user: user!,
                              )),
                    );
                  } on FirebaseAuthException catch (e) {
                    final snackBar = SnackBar(
                      content: Text('${e.message}'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 4.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
                child: const Text("Forgot Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
