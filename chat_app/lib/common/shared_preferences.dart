import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference _sharedPreference = SharedPreference._();

  factory SharedPreference() {
    return _sharedPreference;
  }
  SharedPreference._();

  static void addToken({String token = "", userName, email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("token", [token, userName, email]);
  }

  static Future<List<String>?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? token = prefs.getStringList("token");
    return token;
  }

  static Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
}

enum userInfo { token, userName, email }
