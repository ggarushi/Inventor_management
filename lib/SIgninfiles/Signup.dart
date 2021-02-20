import 'package:flutter/material.dart';
import '../Views/card_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
final _auth=FirebaseAuth.instance;
  String email;
  String password;
  String password2;
  String message="";
  String message2="";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text("SignUp"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      body:SingleChildScrollView(
      child:Container(
        padding:EdgeInsets.symmetric(horizontal: 40),
        height:MediaQuery.of(context).size.height-50,
        width: double.infinity,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget>[
        Column(
        children: <Widget>[
            Text("Sign up", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),),
          SizedBox(height: 20,),
          Text("Create an account, It's free", style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700]
          ),),
         ],),
            Column(
              children: <Widget>[
                //input field for email and password
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
                  keyboardType:TextInputType.emailAddress,
                  obscureText: false,
                  onChanged: (value){
                    email=value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400])
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400])
                    ),
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
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
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400])
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400])
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Confirm Password', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87
            ),),
            SizedBox(height: 5,),
            TextField(
              obscureText: true,
              onChanged: (value){
                password2=value;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])
                ),
              ),
            ),
            SizedBox(height:5),
            Text( message,style:TextStyle(
                color:Colors.red,
              fontSize: 12,
            ),

            ),
            SizedBox(height: 20,),
          ],
        ),
              ],
            ),
            Container(
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
              child:MaterialButton(
                minWidth: double.infinity,
                height: 60,
                //onpress signup button
                onPressed: () async{
                  if(password!=password2){
                  setState(() {
                  message="password is not same";
                  });

                  }
                  else{
              try {
                final newuser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if(newuser!=null )
                {
                  message="";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Listitem()));
                }
              }
              catch(e){
                print(e);
                switch (e.code) {
                  case "ERROR_EMAIL_ALREADY_IN_USE":
                  case "account-exists-with-different-credential":
                  case "email-already-in-use":
                    message2= "Email already used. Go to login page.";
                    break;
                  case "ERROR_OPERATION_NOT_ALLOWED":
                  case "operation-not-allowed":
                   message2= "Server error, please try again later.";
                    break;
                  case "ERROR_INVALID_EMAIL":
                  case "invalid-email":
                    message2= "Email address is invalid.";
                    break;
                  case "weak-password":
                    message2="Minimum 6 characters password";
                    break;
                  default:
                    message2= "Signup failed. Please try again.";
                    break;
                };

                setState(() {
                  message=message2;
                });
              }
}
                },
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account?"),
                Text(" Login", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18
                ),),
              ],
            ),
          ]
        )
      )
      ),
    );
  }}


//take input from user
//Widget takeInput({label, obscureText = false}) {
//  return Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
//      Text(label, style: TextStyle(
//          fontSize: 15,
//          fontWeight: FontWeight.w400,
//          color: Colors.black87
//      ),),
//      SizedBox(height: 5,),
//      TextField(
//        obscureText: obscureText,
//        onChanged: (value){
//          email=value;
//        },
//        decoration: InputDecoration(
//          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//          enabledBorder: OutlineInputBorder(
//              borderSide: BorderSide(color: Colors.grey[400])
//          ),
//          border: OutlineInputBorder(
//              borderSide: BorderSide(color: Colors.grey[400])
//          ),
//        ),
//      ),
//      SizedBox(height: 30,),
//    ],
//  );
//}
//}
//get error message to display