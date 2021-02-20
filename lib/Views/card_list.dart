import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Addview.dart';
import '../Data/Inventorydata.dart';
import '../Data/Sellinginfo.dart';
import '../Data/showdealer.dart';
import 'dealerinfo.dart';
import 'bill generation.dart';
import'package:firebase_auth/firebase_auth.dart';
import '../SIgninfiles/Homepage.dart';
//screen to show card
class Listitem extends StatelessWidget {
//  Carddata task;
//  final List<Carddata>_Cardd=[Carddata(cardname:'Add New Item',ico:'plus'),Carddata(cardname:'Delete Item',ico:'trash'),Carddata(cardname:'Check Inventory',ico:'shopping-basket'),
//    Carddata(cardname:'Dealer Details',ico:'users'),
//    Carddata(cardname:'Add  New Dealer',ico:'user-check'),Carddata(cardname:'Purchase Details',ico:'shopping-cart')];
  final List<String>_Cardd=['Add New Item','Check Inventory','Dealer Details','Add  New Dealer','Selling Details','Generate Bill'];
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
         title: Text('List'),
       backgroundColor: Colors.teal,
         automaticallyImplyLeading: false,
         actions: <Widget>[
           FlatButton(
             onPressed: ()async {
              await  _auth.signOut();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) => Homepage()),(Route<dynamic> route) => false);
             },
             child: Text('SignOut',style:TextStyle(
               color: Colors.white,
             )),
           ),
         ],
    ),
         body: ListView(
           padding: EdgeInsets.all(20),
                children: <Widget>[
              Card(
                //add new item
                margin: EdgeInsets.symmetric(vertical: 12),
                color: Colors.grey[200],
                child: ListTile(
                leading: Icon(FontAwesomeIcons.plus),
                title: Text(_Cardd[0]),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                  25.0),
                  //onpress leads to add sheat
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bottomadd()),
                    );
                  },
                ),
              ),
              //delete item
              //check inventory
              Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                color: Colors.grey[200],
                child: ListTile(
                leading: Icon(FontAwesomeIcons.shoppingBasket),
                title: Text(_Cardd[1]),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                  25.0),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Retrive()),
                    );
                  },
                ),
              ),
                  //dealer details
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.users),
                      title: Text(_Cardd[2]),
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                      25.0),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dealerdis()),
                        );
                      },
                    ),
                  ),
                  Card(
                    //add new dealer
                    margin: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.userCheck),
                      title: Text(_Cardd[3]),
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                      25.0),
                      onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dealerinfo()),
                      );}
                    ),
                  ),
                  Card(
                    //purchase details
                    margin: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.shoppingCart),
                      title: Text(_Cardd[4]),
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                      25.0),
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Salesinfo()),
                        );
                      } ,
                    ),
                  ),
                  Card(
                    //generate bill
                    margin: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.stickyNote),
                      title: Text(_Cardd[5]),
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                      25.0),
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Bill()),
                        );
                      } ,
                    ),
                  ),
    ],
    ));
//       ListView.builder(
//           itemExtent: 100.0,
//           itemCount: _Cardd.length,
//           itemBuilder: (context,index){
////         return Carditem(cardname: _Cardd[index].cardname,icone:_Cardd[index].ico);
//       }));

  }
}
