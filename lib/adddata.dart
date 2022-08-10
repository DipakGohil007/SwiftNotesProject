// TODO Implement this library.
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:swift_notes_project/Screens/Home_Screen.dart';
import './main.dart';

class addnote extends StatefulWidget {
  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('todos/$k');

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_rounded),
          onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return HomeScreen();
            })
            );
          } ,
        ) ,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView (
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: TextField(
                    controller: second,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter Note',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: TextField(
                    controller: third,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'description',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: Colors.blue[600],
                onPressed: () {
                  ref.set({
                    "title": second.text,
                    "subtitle": third.text,
                  }).asStream();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text(
                  "save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
