import 'package:flutter/material.dart';
import '../Views/card_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String message="";
  String message2="";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text("LogIn"),
        //go to previous page
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Login", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      Text("Login to your account", style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600]
                      ),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        //take email input
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Email', style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87
                            ),),
                            SizedBox(height: 5,),
                            TextField(
                              obscureText: false,
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400])
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400])
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                          ],
                        ),
                        //take password input
                        //TODO: decoration take constant reduce size
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Password', style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87
                            ),),
                            SizedBox(height: 5,),
                            TextField(
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400])
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400])
                                ),
                              ),
                            ),
                            SizedBox(height:5),
                            //to print errror message
                            Text(message,style:TextStyle(
                              color:Colors.red,
                              fontSize: 12,
                            )),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async{
                          final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                         try{ if(user!=null){
                           setState(() {
                             message="";
                           });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Listitem()));
                          }}
                          //catching error
                         // TODO:refactor this code later from signup and login page
                          on FirebaseAuthException catch(e){
                           switch(e.code){
                             case "wrong-password":
                               message2="Password is invalid";
                               break;
                             case "invalid-email":
                                message2="Invalid email-address";
                                break;
                             case "user-not-found":
                               message2="User does not exist";
                               break;
                             default :
                               message2="Login failed.Try after some time";
                              break;
                           }
                           setState(() {
                             message=message2;
                           });
                          }

                        },
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Login", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      Text("Sign up", style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18
                      ),),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}