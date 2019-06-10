import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cag_app/models/user.dart';

class PrayerCard extends StatelessWidget {
  final String uid, title, description;
  final int dateInSeconds;

  PrayerCard(
      {@required this.uid,
      @required this.title,
      @required this.dateInSeconds,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    var unformatedDate =
        DateTime.fromMillisecondsSinceEpoch(dateInSeconds * 1000);
    var date =
        "${unformatedDate.month}/${unformatedDate.day}/${unformatedDate.year}";

    return Container(
      margin: EdgeInsets.all(5.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2.0),
                        child: Text(date.toString()),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(description),
                      )
                    ],
                  ),
                ),
                _userName(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Returns the created by section that takes the uid and prints out the real name
  Widget _userName() {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: SizedBox(
            width: double.infinity,
            //// Need to be able to compare the UID with all the docs in the user collection so that
            //// we can return the Name of the user and fill it under the 'Created By: ' section.
            ////
            //// First set up the stream and then go through each document to see if there is a matching 
            //// UID. Then return the 'name' variable from that document
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox();
                  default:
                    {
                      String _username = "";

                      snapshot.data.documents.forEach((doc) {
                        if (doc.documentID == uid) {
                          _username = doc.data['name'];
                        }
                      });
                      return Text(
                        "Created by: $_username",
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      );
                    }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
