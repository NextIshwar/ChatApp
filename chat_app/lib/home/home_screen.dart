import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final List<String>? token;
  UserScreen({this.token});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.5),
        title: Center(
          child: Text(
            "${token?[userInfo.userName.index]}'S CHATBOT",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
