import 'package:flutter/material.dart';

class PrayerCard extends StatelessWidget {
  final String author, title, description;
  final int dateInSeconds;

  PrayerCard(
      {@required this.author,
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
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                Padding(
                  padding: const EdgeInsets.only(top: 9.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Author: $author",
                        style: TextStyle(fontSize: 10.0, color: Colors.grey, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
