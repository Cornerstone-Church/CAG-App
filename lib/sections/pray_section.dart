import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Local imports
import 'package:cag_app/widgets/prayer_card.dart';

class PrayerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prayer Requests',
        ),
        actions: <Widget>[
          // Add Prayer Request Button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addprayer');
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              actionButton('Answered', 'null', Icons.check),
              actionButton('My Requests', 'null', Icons.assignment),
            ],
          ),
          Expanded(
            child: prayerCards(),
          )
        ],
      ),
    );
  }

  Widget prayerCards() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('app/prayer-requests/active')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    print(document.exists);
                return PrayerCard(
                  author: document['author'],
                  title: document['title'].toString().toUpperCase(),
                  dateInSeconds: document['date'].seconds,
                  description: document['description'],
                );
              }).toList(),
            );
        }
      },
    );
  }

  Widget actionButton(String title, String pageRoute, IconData iconImage) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: SizedBox(
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconImage),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(title),
              ),
            ],
          ),
          onPressed: () {
            // TODO: Implement Button
          },
        ),
      ),
    );
  }
}
