import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Data/Billitems.dart';

class Bill extends StatefulWidget {

  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {

  final userid=FirebaseAuth.instance.currentUser.uid;
  final db=FirebaseFirestore.instance;
  String _itemname;
  double _quantity;
  double _cost;
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
    return Scaffold(
     appBar: AppBar(
       title: Text("Select items"),
       backgroundColor: Colors.teal,
      ),
        body: SafeArea(
            child:StreamBuilder<QuerySnapshot>(
              stream:db.collection('userData').doc(userid).collection('item').snapshots(),
              builder:(context,snapshot){
                if(!snapshot.hasData){
                  return Text(
                      'Not able to load Data'
                  );
                }
                final purchasel=snapshot.data.docs;
                return
                ListView.builder(itemCount:purchasel.length,
                    itemBuilder: (context,index){
                      DocumentSnapshot data = snapshot.data.docs[index];
                    return ListTile(
                        trailing: Icon(Icons.add,
                        ),
                      title:Text(
                        data['itemname'],
                      ),
                      subtitle:Text(
                       "${data['itemcost'].toString()} Kg   ${data['itemquantity'].toString()} Rs. "
                      ),
                       //calls bottomsheet to add items in bill
                       onLongPress: (){
//                         showModalBottomSheet(isScrollControlled: true,context: context, builder:(context)=>Billadd());
                          showDialog(context: context,builder:(context)=>Dialog(
                            child:ListView(
                              children: <Widget>[
                                Form(
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
                              ],
                            )
                          ));
                       },
                    );
                    });
              }
            )
        )
    );
  }
}
