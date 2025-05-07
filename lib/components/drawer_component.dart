import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/pages/home_page.dart';
import 'package:tasker/pages/manage_tags.dart';
import 'package:tasker/pages/profile_page.dart';
import 'package:tasker/pages/settings_page.dart';
import 'package:tasker/services/auth_service/auth_state_helper.dart';


class DrawerComponent extends StatelessWidget {

  final BuildContext context;
  DrawerComponent({super.key, required this.context});


  Future <void> _signOut() async {
    await FirebaseAuth
        .instance
        .signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Icon(
                  Icons.add_task_sharp,
                  size: 120,
                ),
                Text(
                  "Tasker",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  title: const Text(
                    "Home Page",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  leading: const Icon(
                    Icons.home,
                    size: 25,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                ListTile(
                  title: const Text(
                    "Manage Tags",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  leading: const Icon(
                    Icons.tag,
                    size: 25,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageTags(),));
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  leading: const Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage(),));
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                ListTile(
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  leading: const Icon(
                    Icons.account_circle,
                    size: 25,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
                  },
                ),
              ],
            ),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
                size: 25,
              ),
              onTap: (){
                _signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
