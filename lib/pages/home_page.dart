import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:town_app/pages/favorites_list.dart';
import 'package:town_app/pages/poi_list.dart';

import 'login_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Menu { logOut }

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    _loadPages();
  }

  void _loadPages() {
    pages.clear();
    pages.add(const POIList());
    pages.add(const FavoritesList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TownApp"),
          actions: [
            PopupMenuButton(
              onSelected: (Menu item) {
                setState(() {
                  if (item == Menu.logOut) {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem(
                  value: Menu.logOut,
                  child: Text("Cerrar sesión"),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Lista",),
              Tab(text: "Favoritos",),
            ],
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}
