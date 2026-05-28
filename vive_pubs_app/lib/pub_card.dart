import 'package:vive_pubs_app/models/pubs.dart';
import 'package:flutter/material.dart';

class PubCard extends StatelessWidget {
  const PubCard(this.pub);
  final Pubs pub;

  @override
  Widget build(BuildContext context) {
    
    return Card(
        child: ListTile(
      leading: CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.transparent,
          backgroundImage:
              NetworkImage('http://localhost:1337${pub.picture.url}')),
      title: Text(pub.name, textAlign: TextAlign.justify),
      subtitle: Text(pub.address),
      trailing: Text(pub.avgPrice.toString()),
      
    ));
  }
}