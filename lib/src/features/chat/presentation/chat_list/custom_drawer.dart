import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 70,
            bottom: 30,
            right: 20,
            left: 20,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/chat.png',
                width: 120,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 40),
              ListTile(
                title: const Text('H O M E'),
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[600],
                ),
              ),
              ListTile(
                onTap: () {
                  context.go('/settings_screen');
                },
                title: const Text('S E T T I N G S'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  context.go('/');
                },
                title: const Text('L O G O U T'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
  }
}