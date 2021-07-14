import 'package:chat_app/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'common/chat_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String>? token;
  @override
  void initState() async {
    super.initState();
    token = await SharedPreference.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, -1),
                      blurRadius: 3,
                      spreadRadius: 3,
                    )
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                child: Text(
                  "Welcome to ChatBot",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: (token != null)
                  ? UserScreen(
                      token: token,
                    )
                  : LoginPage(),
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
