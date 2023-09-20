import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/phone_signin/beranda_page.dart';
import 'package:flutter/material.dart';

class PhoneSigninPage extends StatelessWidget {
  PhoneSigninPage({super.key});
  final phoneController = TextEditingController();
  User? user;

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
                "Halaman Login Phone",
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
                  helperText: '62895895467754',
                ),
                controller: phoneController,
              ),
              const SizedBox(
                height: 24.0,
              ),
              StreamBuilder<User?>(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    user = snapshot.data!;
                    return Text(
                      "${user!.phoneNumber}",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    );
                  }
                  return const Text(
                    "s",
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  );
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "+${phoneController.text}",
                      verificationCompleted: (credential) async {
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                      },
                      verificationFailed: (exception) {
                        final snackBar = SnackBar(
                          content: Text('${exception.message}'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      codeSent: (verificationId, resendCode) async {
                        String? smsCode = await askingSMSCode(context);
                        if (smsCode != null) {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: smsCode,
                          );
                          try {
                            FirebaseAuth.instance
                                .signInWithCredential(credential);
                            log("User: ${user!.phoneNumber}");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BerandaPage(user: user!)),
                            );
                          } on FirebaseAuthException catch (e) {
                            log(e.message.toString());
                          }
                        }
                      },
                      codeAutoRetrievalTimeout: (verificationId) {},
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
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> askingSMSCode(BuildContext context) async {
    return await showDialog<String>(
        context: context,
        builder: (_) {
          TextEditingController controller = TextEditingController();

          return SimpleDialog(
              title: const Text('Please enter the SMS code sent to you'),
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  color: const Color.fromARGB(255, 240, 240, 240),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.green,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'SMS Code'),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, controller.text);
                    },
                    child: Text('Confirm',
                        style: TextStyle(color: Colors.green.shade900)))
              ]);
        });
  }
}
