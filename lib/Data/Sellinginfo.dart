import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Inventorydata.dart';
class Salesinfo extends StatefulWidget {
  @override
  _SalesinfoState createState() => _SalesinfoState();
}

class _SalesinfoState extends State<Salesinfo> {
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
                      stream:db.collection('userData').doc(userid).collection('salesInfo').snapshots(),
                      builder:(context,snapshot){
                        if(!snapshot.hasData){
                          return Text(
                              'Not able to load Data'
                          );
                        }
                        final itemdata=snapshot.data.docs;
                        List<Itemlist>itemWidget=[];
                        for(var items in itemdata){
//                  print(items);
                          final itname=items.data()['itemname'];
                          final itquantity=items.data()['itemquantity'];
                          final itcost=items.data()['itemcost'];
                          final itw=Itemlist(
                              i_name:itname,
                              i_quantity:itquantity,
                              i_cost:itcost,

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
//class saleslist extends StatelessWidget {
//  saleslist({this.i_name,this.i_quantity,this.i_cost});
//  final String i_name;
//  final double i_quantity;
//  final double i_cost;
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//        padding:EdgeInsets.all(10.0),
//        child:Material(
//            borderRadius: BorderRadius.circular(10.0),
//            elevation:5.0,
//            color:Colors.white70,
//            child:Padding(
//                padding:EdgeInsets.symmetric(vertical :10.0,horizontal: 10.0),
//                child:Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    Container(
//                      child:Text(
//                          i_name
//                      ),
//                    ),
//                    Container(
//                      child:Text(
//                          '${i_quantity.toString()} kg'
//                      ),
//                    ),
//                    Container(
//                      child:Text(
//                        '${i_cost.toString()} Rs',
//                      ),
//                    ),
////            Container(
////              child:Text(
////                  dname,
//////                style:TextStyle(
//////                  fontSize: 15.0
//////                ),
////              ),
////            ),
//                  ],
//                )
//            )
//
//        )
//    );;
//  }
//}
