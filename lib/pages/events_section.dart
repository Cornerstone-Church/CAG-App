import 'package:flutter/material.dart';

class EventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        eventCard('Test Title', 'Description'),
        eventCard('Another Title', 'Another Description')
      ],
    );
  }

  /* Generates a card that has the event formating */
  Widget eventCard(String title, String description) {
    return Card(
      child: SizedBox(
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
    );
  }
}
