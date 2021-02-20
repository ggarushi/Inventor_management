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
                         showModalBottomSheet(isScrollControlled: true,context: context, builder:(context)=>Billadd());
                       },
                    );
                    });
              }
            )
        )
    );
  }
}
