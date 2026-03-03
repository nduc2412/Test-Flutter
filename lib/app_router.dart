import 'dart:developer';

import 'package:duckyapp/presentation/bloc/bloc.dart';
import 'package:duckyapp/presentation/note_bloc/note_bloc.dart';
import 'package:duckyapp/presentation/views/auth_views/email_verify_success.dart';
import 'package:duckyapp/presentation/views/auth_views/email_verify_waiting.dart';
import 'package:duckyapp/presentation/views/auth_views/loading_view.dart';
import 'package:duckyapp/presentation/views/auth_views/login_view.dart';
import 'package:duckyapp/presentation/views/auth_views/sign_up_view.dart';
import 'package:duckyapp/presentation/views/main_views/favourite_view.dart';
import 'package:duckyapp/presentation/views/main_views/note_view.dart';
import 'package:duckyapp/presentation/views/main_views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duckyapp/utils/routes/routes.dart';

class AppRouter {
  final NoteBloc noteBloc;
  AppRouter({required this.noteBloc});
  Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {

      case Routes.profileView:
         if (setting.arguments == null) {
           log(name: "AppRouter", "Error: van chua co argument");
         }
        return MaterialPageRoute(
          settings: setting,
          builder: (context) {
            return BlocProvider.value(value: noteBloc, child:  ProfileView());
          },
        );

      case Routes.favouriteView:
        return MaterialPageRoute(
          settings: setting,
          builder: (context) {
            return BlocProvider.value(value: noteBloc, child: const FavouriteView());
          },
        );

      case Routes.savedView:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(value: noteBloc, child: const ProfileView());
          },
        );

      case Routes.settingsView:
        return MaterialPageRoute(

          builder: (context) {
            return BlocProvider.value(value: noteBloc, child: const ProfileView());
          },
        );

      case Routes.noteView:
        return MaterialPageRoute(
          settings: setting,
          builder: (context) {
            return BlocProvider.value(value: noteBloc, child:  NoteView());
          },
        );

      default:
        log(name: "App Router", setting.name.toString());
        return MaterialPageRoute(
          settings: setting,
          builder: (context) {
            return BlocProvider.value(value: noteBloc, child: const ProfileView());
          },
        );
    }
  }
}
