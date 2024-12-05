
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:jdr/class/user.dart';
import 'package:jdr/pages/home_page.dart';
import 'package:jdr/pages/login_or_register.dart';
import 'package:jdr/services/class/user_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final service = UserService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<firebaseAuth.User?>(
        stream: firebaseAuth.FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant que l'état d'authentification est vérifié.
            return Center(child: CircularProgressIndicator());
          } else if (authSnapshot.hasData && authSnapshot.data != null) {
            return FutureBuilder<User>(
              future: service.getCurrentUser(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (userSnapshot.hasError) {
                  return Center(child: Text("Error loading user data: ${userSnapshot.error}"));
                } else if (userSnapshot.hasData) {
                  try {
                    User u = userSnapshot.data!;
                    return MyHomePage(user: u);
                  } on Exception catch (e) {
                    throw Exception(e);
                  }
                } else {
                  return Center(child: Text("No user data found"));
                }
              },
            );
          } else {
            // Si l'utilisateur n'est pas connecté, afficher l'écran de connexion ou d'inscription.
            return LoginOrRegister();
          }
        },
      ),
    );
  }


}
