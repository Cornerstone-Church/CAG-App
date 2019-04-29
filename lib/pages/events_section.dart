import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        eventCard(
            'Cafe Menu',
            'Something Good\nSomething else good\nNothing more\nAnothering\nAWmfmskefmes',
            'assets/prayer_walk-background.jpg',
            true),
        _buildBody(context)
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('cafe-menu').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return snapshot.data.documents.map((document) {
          return ListView(children: snapshot.data.documents.map((document) {
            
          }),);
        });
      },
    );
  }

  /* Generates a card that has the event formating */
  Widget eventCard(
      String title, String description, String imagePath, bool lightText) {
    var textColor = Colors.black;

    if (lightText) {
      textColor = Colors.white;
    }

    return Card(
      // Style
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10,
      margin: EdgeInsets.all(10),

      // Elements
      child: Container(
        height: 200.0,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/cafe.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: textColor))),
                  Text(
                    description,
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
