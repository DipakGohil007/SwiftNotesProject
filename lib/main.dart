import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swift_notes_project/Screens/Home_Screen.dart';

import 'Screens/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),

  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async{
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future:  checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(snapshot.data == false){
            return LoginScreen();
          }
          return HomeScreen();
        },

      ),

    );
  }
}
