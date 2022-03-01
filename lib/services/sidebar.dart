import 'package:admin_app_grocery/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../screens/admin_users.dart';
import '../screens/categories_screen.dart';
import '../screens/manage_banners.dart';
import '../screens/notification_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/settings_screen.dart';

class SidebarWidget {
  SideBarMenus(context,selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black38,
      activeIconColor: Colors.white,
      activeTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.black12,
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: Icons.photo,
        ),
        MenuItem(
          title: 'Categories',
          route: CategoriesScreen.id,
          icon: Icons.category,
        ),
        MenuItem(
          title: 'Orders',
          route: OrderScreen.id,
          icon: CupertinoIcons.cart_fill,
        ),
        MenuItem(
          title: 'Send Notifications',
          route: NotificationScreen.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Admin Users',
          route: AdminUsers.id,
          icon: Icons.person_rounded,
        ),
        MenuItem(
          title: 'Settings',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).popAndPushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child: const Center(
          child: Text(
            'MENU',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 80,
        width: double.infinity,
        color: const Color(0xff444444),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
