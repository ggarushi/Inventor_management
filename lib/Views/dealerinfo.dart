import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Dealerinfo extends StatefulWidget {
  @override
  _DealerinfoState createState() => _DealerinfoState();
}

class _DealerinfoState extends State<Dealerinfo> {
  final _auth=FirebaseAuth.instance;
  String _dealername;
  String _dealerphone;
  String _dealeraddress;
  final db=FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildName(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Dealer Name'),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name of the dealer is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _dealername = value;
      },
    );
  }
  Widget _buildphone(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Mobile Number'),
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _dealerphone = value;
      },
    );
  }
  Widget _buildaddress(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address'),
      maxLength: 80,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address of the dealer is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _dealeraddress = value;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add New Dealer "),
          backgroundColor: Colors.teal,),
        body:SingleChildScrollView(
            child:Container(
                margin:EdgeInsets.all(20.0),
                child:Form(
                    key: _formKey,
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildName(),
                          SizedBox(height: 12),
                          _buildphone(),
                          SizedBox(height: 12),
                          _buildaddress(),
                          SizedBox(height: 12),
                          RaisedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            onPressed: () async{
                              if (!_formKey.currentState.validate()) {
                                return;
                              }

                              _formKey.currentState.save();
                              final  userid =  _auth.currentUser.uid;
                              //storing on firestore
                              await db.collection("userData").doc(userid).collection("item").add({
                                "dealeraddress":_dealeraddress,
                                "dealername":_dealername,
                                "dealerphone":_dealerphone,

                              });
                              Navigator.pop(context);

//                              print(_dealername);
//                              print(_dealerphone);
//                              print(_dealernaddress);

                              //Store the values in database
                            },
                          )

                        ])
                )
            )
        ));
  }
}
