import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference _sharedPreference = SharedPreference._();

  factory SharedPreference() {
    return _sharedPreference;
  }
  SharedPreference._();

  static void addToken({String token = "", userName, email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("token", [token,userName,email]);
  }

  static Future<List<String>?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? token = prefs.getStringList("token");
    return token;
  }
}

enum userInfo{
  token,
  userName,
  email
}