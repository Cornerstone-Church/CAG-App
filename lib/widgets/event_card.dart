import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String _eventName;
  final String _eventDate;
  final String _eventImage;

  EventCard(this._eventName, this._eventDate, this._eventImage);

  @override
  Widget build(BuildContext context) {
    return buildCard(title: _eventName, date: _eventDate, image: _eventImage);
  }

  /// A widget that builds the event card.
  Widget buildCard(
      {@required String title,
      @required String date,
      @required String image,
      bool lightText = false}) {
    var textColor = Colors.black;

    if (lightText) {
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
            Image.asset(
              image,
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
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: textColor),
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    date,
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
