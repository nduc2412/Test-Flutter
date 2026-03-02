import 'dart:developer';

import 'package:duckyapp/app_router.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/get_current_user.dart';
import 'package:duckyapp/injections.dart';
import 'package:duckyapp/presentation/bloc/bloc.dart';
import 'package:duckyapp/presentation/bloc/events.dart';
import 'package:duckyapp/presentation/bloc/states.dart';
import 'package:duckyapp/presentation/views/auth_views/email_verify_success.dart';
import 'package:duckyapp/presentation/views/auth_views/email_verify_waiting.dart';
import 'package:duckyapp/presentation/views/auth_views/loading_view.dart';
import 'package:duckyapp/presentation/views/auth_views/login_view.dart';
import 'package:duckyapp/presentation/views/auth_views/sign_up_view.dart';
import 'package:duckyapp/utils/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'domain/use_cases/auth_use_cases/forgot_password_use_case.dart';
import 'domain/use_cases/auth_use_cases/login_use_case.dart';
import 'domain/use_cases/auth_use_cases/send_email_verification_use_case.dart';
import 'domain/use_cases/auth_use_cases/sign_out_use_case.dart';
import 'domain/use_cases/auth_use_cases/sign_up_use_case.dart';
import 'firebase_options.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("done");
  setUpDependency();
  final appRouter = locator<AppRouter>();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
        loginUseCase: locator<LoginUseCase>(),
        signUpUseCase: locator<SignUpUseCase>(),
        signOutUseCase: locator<SignOutUseCase>(),
        sendEmailVerificationUseCase: locator<SendEmailVerificationUseCase>(),
        sendResetPasswordUseCase: locator<SendResetPasswordUseCase>(),
        getCurrentUserUseCase: locator<GetCurrentUserUseCase>(),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
        routes: {
          Routes.login: (context) => const LoginView(),
          Routes.signUp: (context) => const SignUpView(),
          Routes.loading: (context) => const LoadingView(),
          Routes.verifyEmailWaiting: (context) => const EmailVerifyWaitingView(),
          Routes.verifyEmailSuccess: (context) => const EmailVerifySuccess(),
        },
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is LoadingState) {
          Navigator.pushReplacementNamed(context, Routes.loading);
        } else if (state is UserNotLogInState) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else if (state is UserNotVerifiedActionState) {
          Navigator.pushReplacementNamed(context, Routes.verifyEmailWaiting);
        } else if (state is LoginSuccessState) {
          log(name: "HomePage", state.currentUser.userName.toString());
          Navigator.pushNamed(
            context,
            Routes.profileView,
            arguments: state.currentUser,
          );
        } else {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      child: Container(),
    );
  }
}

// enum MenuAction {logOut}
// class NoteView extends StatefulWidget {
//   const NoteView({super.key});
//   @override
//   State<NoteView> createState() => _NoteViewState();
// }
//
// class _NoteViewState extends State<NoteView> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text("Main UI"),
//         actions: [
//           PopupMenuButton<MenuAction>(
//             onSelected: (value) async {
//               switch (value) {
//                 case MenuAction.logOut:
//                   final shouldLogOut = await showLogOutDialog(context);
//                   if (shouldLogOut) {
//                     FirebaseAuth.instance.signOut();
//                   }
//                   else {
//                     return;
//                   }
//               }
//             },
//             itemBuilder: (context) {
//               return [
//                 const PopupMenuItem<MenuAction>(
//                   value: MenuAction.logOut,
//                   child: Text('Log out'),
//
//                 ),
//               ];
//             }
//           )
//         ],
//       ),
//     );
//   }
// }
// Future<bool> showLogOutDialog(BuildContext context) {
//   return showDialog<bool>(
//        context: (context),
//        builder: (context) {
//           return AlertDialog(
//             title: const Text("Log out"),
//             content: const Text('Are you sure you want to log out ?'),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false);
//                }, child: const Text('Cancel'),
//               ),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true);
//                   }, child: const Text('Log out'),
//               ),
//             ],
//           );
//        },
//    ).then((value) => value ?? false);
// }
//
