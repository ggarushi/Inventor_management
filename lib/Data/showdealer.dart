import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Dealerdis extends StatefulWidget {
  @override
  _DealerdisState createState() => _DealerdisState();
}

class _DealerdisState extends State<Dealerdis> {
  final userid=FirebaseAuth.instance.currentUser.uid;
  final db=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Inventory"),
          backgroundColor: Colors.teal,),
        body:SafeArea(
            child:Column(
                children:<Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream:db.collection('userData').doc(userid).collection('dealerinfo').snapshots(),
                      builder:(context,snapshot){
                        if(!snapshot.hasData){
                          return Text(
                              'Not able to load Data'
                          );
                        }
                        final itemdata=snapshot.data.docs;
                        List<Dealerlist>itemWidget=[];
                        for(var items in itemdata){
//                  print(items);
                          final dname=items.data()['dealername'];
                          final dphone=items.data()['dealerphone'];
                          final daddress=items.data()['dealeraddress'];

                          final itw=Dealerlist(
                              d_name:dname,
                              d_phone:dphone,
                              d_add:daddress,
                          );
                          itemWidget.add(itw);
                        }
                        return Expanded(
                          child:ListView(
                            padding:EdgeInsets.symmetric(horizontal: 10.0,vertical:10.0),
                            children:itemWidget,
                          ),
                        );
                      }
                  )
                ]
            )
        )
    );;
  }
}
class Dealerlist extends StatelessWidget {
  Dealerlist({this.d_name,this.d_phone,this.d_add});
  final String d_name;
  final String d_phone;
  final String d_add;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:EdgeInsets.all(10.0),
        child:Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation:5.0,
            color:Colors.white70,
            child:Padding(
                padding:EdgeInsets.symmetric(vertical :10.0,horizontal: 10.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child:Text(
                          d_name
                      ),
                    ),
                    Container(
                      child:Text(
                          d_phone
                      ),
                    ),
                    Container(
                      child:Text(
                        d_add
                      ),
                    ),
                  ],
                )
            )

        )
    );
  }
}