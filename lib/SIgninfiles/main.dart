import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Homepage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Myhome()
    );
  }
}

class Myhome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body :SafeArea(
            child:Align(
              alignment: Alignment.center,
              child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
              Text("Let's manage together...",
                  textAlign:TextAlign.center,
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 40,
                color:Colors.white,


              )),
                 SizedBox(height:20),
                 RaisedButton(
                    child: Text('Start'),
                  padding: const EdgeInsets.all(15.0),
                   textColor: Colors.black,
                   color: Colors.white,
                    hoverElevation: 20.0,
                    onPressed: () {
                      print('Pressed');
//
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                  )
                ],

        ),
            )
      ) ,
    );
  }
}

