// Package Imports
import 'package:flutter/material.dart';

// Local Imports
import './live_section.dart';
import './events_section.dart';
import './sermons_section.dart';

var dir = "MAIN:";

void main() => runApp(CornerstoneApp());

class CornerstoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAG',
      home: HomePage(),
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
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), title: Text('Live')),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), title: Text('Sermons')),
          BottomNavigationBarItem(icon: Icon(Icons.event), title: Text('Events'))
        ],
        currentIndex: _menuIndex,
        onTap: _onTapMenu,
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
    Will return the selected view bassed on the index passed to it.
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
      default:
        print("$dir Unknown section selected.");
        // Returns a blank container when the section is invalid
        return Container();
    }
  }
}