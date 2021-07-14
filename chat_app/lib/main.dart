import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'common/chat_imports.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
      home: HomePage('Welcome'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  HomePage(this.title);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBody: true,body: Container(
      child: Column(children: [
        Expanded(child: Container(
          alignment: Alignment.center,
          child: Text("Welcome to ChatBot"),
        ),flex: 1,),
        Expanded(child: LoginPage(), flex: 3,),
      ],),
    ));
  }
}
