import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jdr/auth/auth_gate.dart';
import 'package:jdr/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade500,
          secondary: Colors.grey.shade200,
          tertiary: Colors.deepOrangeAccent,
          inversePrimary: Colors.grey.shade900,
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade700,
          secondary: Colors.grey.shade800,
          tertiary: Colors.deepOrangeAccent,
          inversePrimary: Colors.grey.shade900
        )
      ),
      debugShowCheckedModeBanner: true,
      home: const AuthGate(),
    );
  }
}
