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
        CafeCard('saturday'),
      ],
    );
  }

//  Widget _buildBody(BuildContext context) {
////    return StreamBuilder(
////      stream: Firestore.instance.collection('cafe-menu').snapshots(),
////      builder: (context, snapshot) {
////        if (snapshot.hasError) {
////          return Text('There is an error: ${snapshot.error}');
////        }
////        switch (snapshot.connectionState) {
////          case ConnectionState.done:
////            return Text("done");
////          case ConnectionState.waiting:
////            return Text("waiting");
////          case ConnectionState.none:
////            return Text("none");
////          default:
////            {
////              Widget output = Text("Not Working");
////              Firestore.instance
////                  .collection('cafe-menu')
////                  .document('wednesday')
////                  .get()
////                  .then((DocumentSnapshot ds) {
////                print(ds.data);
////
////                output = Text("Working!");
////              });
////
////              return output;
////            }
////        }
////      },
////    );
//  }
}
