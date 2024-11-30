import 'package:flutter/material.dart';
import 'package:jdr/auth/auth_service.dart';
import 'package:jdr/components/my_button.dart';
import 'package:jdr/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  RegisterPage({super.key});

  void register(BuildContext context) {
    final authService = AuthService();

    if(passwordController.text == password2Controller.text) {
      try {
        authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
      } on Exception catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Error : $e', style: TextStyle(fontSize: 15),),
        ),);
      }
    } else {

      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Password need to match !', style: TextStyle(fontSize: 15),),
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
            Text('R E G I S T E R', style: TextStyle(fontSize: 30),),
            SizedBox(height: 30),
            MyTextField(hintText: 'Email', obscureText: false, controller: emailController),
            SizedBox(height: 10),
            MyTextField(hintText: 'Password', obscureText: true, controller: passwordController),
            SizedBox(height: 10),
            MyTextField(hintText: 'Confirm password', obscureText: true, controller: password2Controller),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => register(context),
              child: MyButton(text: 'Sign up', color: Colors.deepOrangeAccent,)
            ),
            SizedBox(height: 10),
            MyButton(
              text: 'Back to login',
              onTap: () {
                Navigator.pop(context);
              }
            ),
          ],
        ),
      ),
    );
  }
}
