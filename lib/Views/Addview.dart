import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//add screen
class Bottomadd extends StatefulWidget {
  @override
  _BottomaddState createState() => _BottomaddState();
}

class _BottomaddState extends State<Bottomadd> {
  final _auth=FirebaseAuth.instance;
  User loguser;
  String _itemname;
 double _itemquantity;
  double _itemcost;
  String _dealername;

  final db=FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //textfield for item name
  Widget _buildName(){
        return TextFormField(
          decoration: InputDecoration(labelText: 'Item Name'),
          maxLength: 30,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Name of item is Required';
            }

            return null;
          },
          onSaved: (String value) {
            _itemname = value;
          },
        );
  }
  //textfield for quantity
  Widget _buildquantity(){
      return TextFormField(
        decoration: InputDecoration(labelText: 'Item Quantity(in Kg)',),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'quantity is Required';
          }

          return null;
        },
        onSaved: (String value) {
          _itemquantity = double.parse(value);
        },
      );
  }
  //textfield for cost
  Widget _buildcost(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Item Cost'),
      keyboardType: TextInputType.number,
      validator: (String  value) {
        if (value.isEmpty) {
          return 'cost price of the item is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _itemcost = double.parse(value);
      },
    );
  }
  //textfield for dealer
  Widget _builddealer(){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item"),
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
                  _buildquantity(),
                        SizedBox(height: 12),
                  _buildcost(),
                        SizedBox(height: 12),
                  _builddealer(),
                  SizedBox(height: 100),
//                        Text(
//                          message,
//                          style: TextStyle(color: Colors.blue, fontSize: 13),
//                        ),
                  RaisedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: ()async{
                      if (!_formKey.currentState.validate()) {
                     return;
                   }
//                Store the values in database
                    else{
                        _formKey.currentState.save();

                    //getting userid
                    final  userid =  _auth.currentUser.uid;
                   //storing on firestore
                    await db.collection("userData").doc(userid).collection("item").add({
                      "itemname":_itemname,
                      "itemquantity":_itemquantity,
                      "itemcost":_itemcost,
                      "dealername":_dealername,

                    });
                        Navigator.pop(context);

//                      setState((){
//                        message="fields must be field correctly";
//                      })
                  }
                    },
                  )


        ])
        )
      )
    ));
  }
}

