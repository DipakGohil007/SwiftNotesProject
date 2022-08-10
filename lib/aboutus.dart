import 'package:flutter/material.dart';
import 'package:swift_notes_project/Screens/Home_Screen.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Our Team",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade700,
          ),),
        )
      ),
    );
  }
}
