import 'package:flutter/material.dart';
import 'package:cag_app/widgets/prayer_card_list.dart';

class PrayPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prayer Requests',
        ),
        actions: <Widget>[
          // Add Prayer Request Button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addprayer');
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _actionButton(title: 'Answered', context: context, pageRoute: '/answeredPrayers', iconImage: Icons.check),
              _actionButton(title: 'My Requests', context: context, pageRoute: '/requestEditor', iconImage: Icons.list),
            ],
          ),
          Expanded(
            child: PrayerCardList(),
          )
        ],
      ),
    );
  }

  Widget _actionButton({@required String title, String pageRoute, IconData iconImage, @required BuildContext context}) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: SizedBox(
        child: RaisedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconImage),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(title),
              ),
            ],
          ),
          onPressed: () {
            if (pageRoute != null) {
              Navigator.pushNamed(context, pageRoute);
            }
          },
        ),
      ),
    );
  }
}
