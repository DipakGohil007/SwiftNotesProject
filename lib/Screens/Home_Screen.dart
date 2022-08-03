import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../adddata.dart';
import '../main.dart';
import 'Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Membuat App Bar pada MObile TODO list
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Swift Notes",
      theme: ThemeData(
        primaryColor: Colors.greenAccent[700],
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final fb = FirebaseDatabase.instance;
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
  var l;
  var g;
  var k;

  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child(todos);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => addnote(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),

      appBar: AppBar(
        title: Text(
          'Swift Notes',
        ),
        centerTitle: true,
        actions: [
          IconButton(
          onPressed: () async {
            await _signOut();
            if (_firebaseAuth.currentUser == null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),);
            }
            }
              , icon: Icon(Icons.logout))
        ],

        backgroundColor: Colors.blueGrey[900],
      ),
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v = snapshot.value.toString();

          g = v.replaceAll(
              RegExp("{|}|subtitle: |title: "), "");
          g.trim();

          l = g.split(',');

          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: second,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                  ),
                  content: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: third,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'description',
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      color: Colors.blue,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await upd();
                        Navigator.of(ctx).pop();
                      },
                      color: Colors.blue,
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tileColor: Colors.blueGrey[200],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Text(
                    l[1],
                    // 'dd',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      l[0],
                      // 'dd',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String get todos => 'todos';
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('k', k));
  }
}

upd() async {
  DatabaseReference ref1 = FirebaseDatabase.instance.ref("todos/k");

// Only update the name, leave the age and address!
  var second;
  var third;
  await ref1.update({
    "title": second.text,
    "subtitle": third.text,
  });
  second.clear();
  third.clear();
}

















    // return Scaffold(
    //   backgroundColor: Colors.blue[100],
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text('You have logged in Successfuly'),
    //         SizedBox(height: 50),
    //         Container(
    //           height: 60,
    //           width: 150,
    //           child: ElevatedButton(
    //               clipBehavior: Clip.hardEdge,
    //               child: Center(
    //                 child: Text('Log out'),
    //               ),
    //               onPressed: () async {
    //                 await _signOut();
    //                 if (_firebaseAuth.currentUser == null) {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(builder: (context) => LoginScreen()),
    //                   );
    //                 }
    //               }),
    //         )
    //       ],
    //     ),
    //   ),
    // );
