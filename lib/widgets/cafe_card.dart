import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CafeCard extends StatelessWidget {
  final String _menuDay;

  CafeCard(this._menuDay);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('cafe-menu')
          .document(_menuDay)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
          default:
//            return buildCard('Cafe Menu', snapshot.data['items'], null, false);
            return buildCard(title: "Cafe Menu", items: snapshot.data['items']);
        }
      },
    );
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

  /// A widget that builds the cafe menu card.
  Widget buildCard({@required
      String title, @required List<dynamic> items, String imagePath, bool lightText = false}) {
    var textColor = Colors.black;
    String itemsString = "";

    items.forEach((element) {
      itemsString += (element + '\n');
    });

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
//            Image.asset(
//              'assets/cafe.jpg',
//              fit: BoxFit.cover,
//              width: double.infinity,
//            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: textColor),
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    itemsString,
                    style: TextStyle(color: textColor),
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
