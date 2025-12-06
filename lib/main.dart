import 'package:duckyapp/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    home : const HomePage(),
    routes : {
      '/login/' : (context) => const LoginView(),
      '/register/' : (context) => const RegisterView(),
      '/home/' : (context) => const HomePage(),
    }
  )
  );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  if (user.emailVerified) {
                    return const NoteView();
                  } else {
                    return const VerifyEmailView();
                  }
                } else {
                  return const  LoginView();
                }
              default:
                return CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
enum MenuAction {logOut}
class NoteView extends StatefulWidget {
  const NoteView({super.key});
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logOut:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    FirebaseAuth.instance.signOut();
                  }
                  else {
                    return;
                  }
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logOut,
                  child: Text('Log out'),

                ),
              ];
            }
          )
        ],
      ),
    );
  }
}
Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
       context: (context),
       builder: (context) {
          return AlertDialog(
            title: const Text("Log out"),
            content: const Text('Are you sure you want to log out ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
               }, child: const Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }, child: const Text('Log out'),
              ),
            ],
          );
       },
   ).then((value) => value ?? false);
}





