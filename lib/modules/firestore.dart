import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  Map<String, String> wednesdayMenu(BuildContext context) {
    Map<String, String> _data;

    StreamBuilder(
      stream: Firestore.instance.collection('cafe-menu').document('wednesday').snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: {
            Firestore.instance.collection('cafe-menu').document('wednesday').get().then((DocumentSnapshot ds) {
              _data = ds.data['date'];
            });
            return CircularProgressIndicator();
          }
          default: return Text("");
        }
      },
    );

    return _data;
  }
}
