import 'package:chat_app/common/chat_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.black.withOpacity(0.5),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            User? user =
                await Authentication.signInWithGoogle(context: context);
            if (user != null) {
              print(user);
              var token = await user.getIdToken();
              SharedPreference.addToken(token: token);
            }
          },
          icon: Icon(Icons.email),
          label: Text("Sign in with google"),
        ),
      ),
    );
  }
}
