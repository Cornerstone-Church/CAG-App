// Package Imports
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Local Imports
import 'sections/live_section.dart';
import 'sections/events_section.dart';
import 'sections/sermons_section.dart';
import 'sections/pray_section.dart';
import 'pages/prayer_add_page.dart';
import 'pages/authentication_page.dart';
import 'pages/request_editor.dart';
import 'pages/answered_page.dart';
import 'models/user.dart';

var TAG = 'MAIN: ';

void main() => runApp(CornerstoneApp(
      userModel: UserModel(),
    ));

class CornerstoneApp extends StatelessWidget {
  final UserModel userModel;

  const CornerstoneApp({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: userModel,
      child: MaterialApp(
        title: 'CAG',
        home: HomePage(),
        routes: {
          // Prayer Routes
          '/addprayer': (context) => AddPrayerRequestPage(),
          '/login': (context) => AuthenticationPage(),
          '/requestEditor': (context) => RequestEditor(),
          '/answeredPrayers': (context) => AnsweredPrayerPage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loadPage(_menuIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv), title: Text('Live')),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), title: Text('Sermons')),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), title: Text('Events')),
          BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('Pray')),
        ],
        currentIndex: _menuIndex,
        onTap: _onTapMenu,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onTapMenu(int index) {
    setState(() {
      _menuIndex = index;
    });

    print('Pressed on button ' + index.toString());
  }

  /* 
    Will return the selected view based on the index passed to it.
    Valid index is 0-2.
   */
  Widget loadPage(index) {
    switch (index) {
      case 0:
        return LiveSection();
      case 1:
        return SermonsSection();
      case 2:
        return EventsSection();
      case 3:
        return PrayerSection();
      default:
        print("$TAG Unknown section selected.");
        // Returns a blank container when the section is invalid
        return Container();
    }
  }
}
