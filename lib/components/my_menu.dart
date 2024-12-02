import 'package:flutter/material.dart';
import 'package:jdr/components/my_item_menu.dart';

import '../services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  
  final _auth = AuthService();
  MyDrawer({super.key});

  void logout() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 150,
                padding: EdgeInsets.only(top:45),
                child: Column(
                  children: [
                    Icon(Icons.person, color: Theme.of(context).colorScheme.tertiary, size: 64,),
                    Text(_auth.getCurrentUser()!.email.toString()),
                  ],
                ),
              ),
              MyItemMenu(
                text: "H O M E", 
                icon: Icons.home, 
                onTap: () {Navigator.pop(context);},
              ),
              MyItemMenu(text: "P R O F I L E", icon: Icons.person, onTap: () {},),
              MyItemMenu(text: "M E S S A G E", icon: Icons.message, onTap: () {},),
            ],
          ),
          Column(
            children: [
              MyItemMenu(text: "S H O P", icon: Icons.shop),
              MyItemMenu(
                text: "L O G O U T", 
                icon: Icons.logout,
                onTap: logout,
              ),
              Container(height: 20,)
            ],
          ),
        ],
      )
    );
  }
}