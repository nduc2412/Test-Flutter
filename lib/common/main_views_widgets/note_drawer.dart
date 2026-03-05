import 'package:duckyapp/presentation/bloc/events.dart';
import 'package:duckyapp/utils/const/color.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/note_space.dart';
import 'package:duckyapp/utils/const/size/NImageSize.dart';
import 'package:duckyapp/utils/const/size/button_size.dart';
import 'package:duckyapp/utils/const/size/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../presentation/bloc/bloc.dart';
import '../../utils/const/note_text.dart';
import '../../utils/routes/routes.dart';

class NoteDrawer extends StatelessWidget {
  final String currentRoute;
  final AuthUserEntity user;

  const NoteDrawer({required this.currentRoute, super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    late final int index;

    // Cập nhật lại logic gán index (Bỏ MyNote và Saved)
    switch (currentRoute) {
      case Routes.profileView:
        index = DrawerIndex.profile;
        break;
      case Routes.favouriteView:
        index = DrawerIndex.favourite;
        break;
      case Routes.settingsView:
        index = DrawerIndex.settings;
        break;
      default:
        index = -1; // Hoặc một giá trị mặc định không thuộc các mục trên
        break;
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(color: Colors.yellow),
            child: Column(
              children: [
                Icon(Icons.person, size: NImageSize.profileAvatarHeight),
                Text(
                  user.userName,
                  style: const TextStyle(
                    fontSize: NTextSize.profileTextFontSize,
                    fontWeight: NFontWeight.boldFontWeight,
                  ),
                ),
              ],
            ),
          ),

          // Mục Profile
          DrawerItem(
            currentPageIndex: index,
            itemIndex: DrawerIndex.profile,
            titleText: NText.profile,
            icon: (index == DrawerIndex.profile)
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outline),
            onTap: () {
              // Dùng pushReplacementNamed nếu không muốn chồng tầng Navigator
              Navigator.pushReplacementNamed(
                context,
                Routes.profileView,
                arguments: user,
              );
            },
          ),

          // Mục Favourite
          DrawerItem(
            currentPageIndex: index,
            itemIndex: DrawerIndex.favourite,
            titleText: NText.favourite,
            icon: (index == DrawerIndex.favourite)
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                Routes.favouriteView,
                arguments: user,
              );
            },
          ),

          // Mục Settings
          DrawerItem(
            currentPageIndex: index,
            itemIndex: DrawerIndex.settings,
            titleText: NText.settings,
            icon: (index == DrawerIndex.settings)
                ? const Icon(Icons.settings)
                : const Icon(Icons.settings_outlined),
          ),

          // Mục Logout
          DrawerItem(
            onTap: () {
              context.read<AuthBloc>().add(LogoutButtonClickedEvent());
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            currentPageIndex: index,
            itemIndex: DrawerIndex.logOut,
            titleText: NText.logout,
            icon: (index == DrawerIndex.logOut)
                ? const Icon(Icons.logout)
                : const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,

    required this.currentPageIndex,

    required this.itemIndex,

    required this.titleText,

    this.onTap,

    this.icon,
  });

  final int currentPageIndex;

  final int itemIndex;

  final String titleText;

  final Icon? icon;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      height: NButtonSize.drawerButtonSize,

      child: ListTile(
        onTap: onTap,

        leading: icon,

        title: Text(
          titleText,
          style: TextStyle(fontSize: NTextSize.drawerButtonFontSize),
        ),
        selected: currentPageIndex == itemIndex,
        selectedTileColor: NColors.blackOnSelected,
      ),
    );
  }
}

class DrawerText extends Text {
  final String text;

  const DrawerText(this.text, {super.key})
    : super(
        text,
        style: const TextStyle(
          fontSize: NTextSize.drawerButtonFontSize,
          fontWeight: NFontWeight.boldFontWeight,
        ),
      );
}

class DrawerIndex {
  static const int profile = 1;
  static const int favourite = 2;
  static const int settings = 4;
  static const int logOut = 5;
}
