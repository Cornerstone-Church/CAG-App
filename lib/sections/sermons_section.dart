import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SermonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut();
    return Text("Signed out");
  }
}
