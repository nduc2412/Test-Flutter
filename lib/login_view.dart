import 'package:duckyapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
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
                          final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                        } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password.');
                            } else if (e.code == 'user-disabled') {
                              print("This user has been disabled");
                            } else if (e.code == "invalid-email") {
                              print("Invalid email");
                            }
                            else {
                              print(e.code);
                            }
                        }
                      }, child: const Text("Login"),
                      ),
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

