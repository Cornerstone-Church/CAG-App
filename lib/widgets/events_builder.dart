import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsBuilder extends StatelessWidget {
  final String _eventsCollection;

  EventsBuilder(this._eventsCollection);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection(_eventsCollection).snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
            default:
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    buildCard(snapshot.data.documents[index]),
              );
          }
        });
  }

  Widget loading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  /// A widget that builds the event card.
  Widget buildCard(DocumentSnapshot doc) {
    var textColor = Colors.black;

    if (doc['lightText']) {
      textColor = Colors.white;
    }

    return Card(
      // Style
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      margin: EdgeInsets.all(10),

      // Elements
      child: Container(
        height: 200.0,
        child: Stack(
          children: <Widget>[
            // FutureBuilder(
            //   future: storageUrl('events/image.png'),
            //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //     Widget child;
            //     if (snapshot.hasData) {
            //       child = Image.network(snapshot.data);
            //     } else {
            //       child = loading();
            //     }
            //     return child;
            //   },
            // ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        doc['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: textColor),
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    doc['date'],
                    style: TextStyle(fontSize: 13.0, color: textColor),
                    textAlign: TextAlign.center,
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
