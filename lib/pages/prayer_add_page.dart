import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddPrayerRequestPage extends StatefulWidget {
  @override
  State<AddPrayerRequestPage> createState() {
    return _AddPrayerRequestState();
  }
}

class _AddPrayerRequestState extends State<AddPrayerRequestPage> {
  final _prayerRequestKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _title, _description;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Prayer Request"),
      ),
      body: Form(
        key: _prayerRequestKey,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                  maxLength: 35,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter a title for your prayer request';
                    _title = value.toString();
                  }),
              TextFormField(
                  maxLines: 6,
                  maxLength: 240,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter a title for your prayer request';
                    _description = value.toString();
                  }),
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    iconSize: 50.0,
                    onPressed: () {
                      if (_prayerRequestKey.currentState.validate()) {
                        Firestore.instance
                            .collection('app/prayer-requests/active')
                            .document()
                            .setData({
                          'title': _title,
                          'description': _description,
                          'date': DateTime.now(),
                          'author': "User Name",
                          'userId': "UserID",
                          'answered': false,
                        }).then((error) {
                          Navigator.pop(context);
                        });
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
