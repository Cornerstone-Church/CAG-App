import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// local
import 'package:cag_app/widgets/prayer_card_list.dart';
import 'package:cag_app/models/user.dart';

class RequestEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Requests'),
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        print(model.uid);
        return PrayerCardList(userID: model.uid,);
      },),
    );
  }
}
