import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cag_app/widgets/prayer_card.dart';

class PrayerCardList extends StatelessWidget {
  final String userID;

  const PrayerCardList({this.userID});

  @override
  Widget build(BuildContext context) {
    return _prayerCards();
  }

  Widget _prayerCards() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('app/prayer-requests/active')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            );
          default:
            bool _isEmpty = false;

            if (snapshot.data.documents.isEmpty) {
              _isEmpty = true;
            } else {
              _isEmpty = false;
            }

            return _isEmpty
                ? _noPrayerRequests()
                : (userID != null)
                // Has to be a better way to filter user prayers
                    ? ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                              print(userID);
                        if (userID == document['userId']) {
                          return PrayerCard(
                            uid: document['userId'],
                            title: document['title'].toString().toUpperCase(),
                            dateInSeconds: document['date'].seconds,
                            description: document['description'],
                          );
                        } else {
                          return SizedBox();
                        }
                      }).toList())
                    : ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return PrayerCard(
                            uid: document['userId'],
                            title: document['title'].toString().toUpperCase(),
                            dateInSeconds: document['date'].seconds,
                            description: document['description'],
                          );
                        }).toList(),
                      );
        }
      },
    );
  }

  Widget _noPrayerRequests() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Text(
          'No prayer requests yet! Be the first to make one.\nPress the + button to create a prayer request.',
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
