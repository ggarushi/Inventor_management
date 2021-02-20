import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Billadd extends StatefulWidget {
  @override
  _BilladdState createState() => _BilladdState();
}

class _BilladdState extends State<Billadd> {
  final _auth=FirebaseAuth.instance;
 String _itemname;
  double _quantity;
  double _cost;
  final db=FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        _cost = double.parse(value);
      },
    );
  }
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
        _quantity = double.parse(value);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          color:Color(0xff757575),
          child:Container(
          decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(10.0),
            topRight: Radius.circular(10.0),

          )
      ),
      child:Container(
          padding:EdgeInsets.all(10.0),
          child:Form(
              key: _formKey,
              child:
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildquantity(),
                    SizedBox(height: 8.0),
                    _buildcost(),
                    SizedBox(height: 8.0),
                    _buildName(),
                    SizedBox(height: 8.0),
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
                          await db.collection("userData").doc(userid).collection("salesInfo").add({
                            "itemname":_itemname,
                            "itemquantity":_quantity,
                            "itemcost":_cost,


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
          ),
      ),
    );
  }
}
