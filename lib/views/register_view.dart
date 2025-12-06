
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email; // this is just a null
  late final TextEditingController _password; // this is just a null
  @override
  void initState() {
    _email = TextEditingController(); // this is where we actually create an instance
    _password = TextEditingController(); // this is where we actually create an instance
    // we need an instance to use that class method or something
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                    children: [
                      TextField(controller: _email,
                        decoration: const InputDecoration(
                            hintText: "Enter your email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(controller: _password,
                        decoration: const InputDecoration(
                            hintText: "Enter your password"),
                        obscureText: true,
                      ),
                      TextButton(onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak);');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          } else if (e.code == 'invalid-email') {
                            print('The email is invalid.');
                          }
                          else {
                            print(e.code);
                          }
                        }
                      },
                        child: const Text("Register"),
                      ),
                      TextButton(onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false,);
                      },
                      child : Text("Already have account ? Go to login !"),
                      )
                    ]
                );
              case ConnectionState.waiting:
                return const Text("Loading");
              default:
                return const Text("Something went wrong");
            }
          }
      ),
    );
  }
}
