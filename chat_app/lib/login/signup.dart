import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          children: [
            textFormField(
                context, nameController, "Enter your name", Icons.person,
                (val) {
              if (val?.trim().isEmpty ?? false) {
                return "Please enter your name";
              } else {
                return null;
              }
            }, false),
            textFormField(
                context, nameController, "Enter your email", Icons.person,
                (val) {
              if (val?.trim().isEmpty ?? false) {
                return "Please enter your name";
              } else {
                return null;
              }
            }, false),
            textFormField(
                context, nameController, "Enter your password", Icons.person,
                (val) {
              if (val?.trim().isEmpty ?? false) {
                return "Please enter your name";
              } else {
                return null;
              }
            }, true),
          ],
        ),
      ),
    );
  }
}

Widget textFormField(
    BuildContext context,
    TextEditingController controller,
    String hintText,
    IconData icon,
    String? Function(String?)? validator,
    bool obscure) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      hintText: hintText,
      suffixIcon: Icon(icon),
    ),
    validator: validator,
    obscureText: obscure,
  );
}
