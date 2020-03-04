import 'package:flutter/material.dart';
import 'package:cag_app/widgets/cafe_card.dart';
import 'package:cag_app/widgets/events_builder.dart';

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
        // TODO: Fix Event/Cafe cards background image
        CafeCard('wednesday'),
        EventsBuilder('events'),
      ],
    );
  }
}
