import 'package:flutter/material.dart';
import 'package:cag_app/widgets/cafe_card.dart';

class EventsSection extends StatefulWidget {
  @override
  State createState() {
    return _EventsSectionState();
  }
}

class _EventsSectionState extends State<EventsSection> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ListView(
      children: <Widget>[
        CafeCard('wednesday'),
      ],
    );
  }
}
