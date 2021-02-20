import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Carditem extends StatelessWidget {
  final String cardname;
  final String icone;
  Carditem({this.cardname,this.icone});
  @override
  Widget build(BuildContext context) {
    return Center(
  child:Card(
      color: Colors.grey[200],
        child:ListTile(
          leading: Icon(FontAwesomeIcons.addressBook),
          title:Text(cardname,textScaleFactor: 1.5,),
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
        25.0),
          dense:true,

        )
  )
    );
  }
}
