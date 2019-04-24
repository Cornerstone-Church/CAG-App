import 'package:flutter/material.dart';

class EventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        eventCard('Cafe', 'Something Good\nSomething else good\nNothing more', 'assets/prayer_walk-background.jpg'),
      ],
    );
  }

  /* Generates a card that has the event formating */
  Widget eventCard(String title, String description, String imagePath) {
    return Card(
      // Style
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.all(10),

      // Elements
      child: Stack(
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(20.0),
              // color: Colors.green,
              child: Column(
                // Prevents the column from expanding to fit the height
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Title Element
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Description Element
                  Text(description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
