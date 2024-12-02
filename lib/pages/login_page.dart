import 'package:flutter/material.dart';
import 'package:jdr/components/my_button.dart';
import 'package:jdr/components/my_textfield.dart';
import 'package:jdr/services/auth/auth_service.dart';
import 'package:jdr/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) async {
    final authService = AuthService();
     
    try {
      await authService.signInWithEmailPassword(emailController.text, passwordController.text);
      Navigator.pop(context);
    } catch(e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Error : $e', style: TextStyle(fontSize: 15),),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('L O G I N', style: TextStyle(fontSize: 30),),
            SizedBox(height: 30),
            MyTextField(hintText: 'Email', obscureText: false, controller: emailController),
            SizedBox(height: 10),
            MyTextField(hintText: 'Password', obscureText: true, controller: passwordController),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => login(context),
              child: MyButton(text: 'Sign in', color: Colors.deepOrangeAccent,)
            ),
            SizedBox(height: 10),
            MyButton(
              text: 'Register',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
