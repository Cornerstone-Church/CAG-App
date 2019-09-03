import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cag_app/pages/authentication_page.dart';
import 'package:cag_app/pages/pray_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
bool _signedIn = false;

class PrayerSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrayerSectionState();
  }
}

class _PrayerSectionState extends State<PrayerSection> {
  @override
  Widget build(BuildContext context) {
    // TODO: Create signout section to remove this
    // _auth.signOut();

    // Check if user is logged in or not
    return StreamBuilder(
      stream: _auth.currentUser().asStream(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            // If isSignedIn is false then load authentication page, Otherwise load the prayer section
            if (snapshot.data == null) {
              _signedIn = false;
            } else {
              _signedIn = true;
            }
            return _signedIn ? PrayPage() : _signIn(context);
        }
      },
    );
  }

  Widget _signIn(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.lock,
            size: 100.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'This section requires you to log in to your \nCornerstone ONE account.',
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            child: Text('Login'),
            onPressed: () async {
              // Navigator.pushNamed(context, '/login');
              var result = await Navigator.pushNamed(context, '/login');

              setState(() {
                _signedIn = result;
              });
            },
          )
        ],
      ),
    );
  }
}
