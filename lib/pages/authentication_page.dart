import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cag_app/modules/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _key = GlobalKey<FormState>();
Widget _loginWidget = Text('Login');
Widget _errorMessage = SizedBox();

class AuthenticationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationPageState();
  }
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final user = new User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
    String _email, _password;

    return Form(
      key: _key,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Icon(
              Icons.lock,
              size: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This section requires you to login to your CornerstoneONE account to access it. Please login to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your e-mail';
                  } else {
                    _email = value;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  } else {
                    _password = value;
                  }
                },
              ),
            ),
            // Add spacing
            SizedBox(
              height: 8.0,
            ),
            SizedBox(
              child: _errorMessage,
            ),
            FlatButton(
              child: _loginWidget,
              onPressed: () {
                if (_key.currentState.validate()) {
                  setState(() {
                    // Change to loading progress
                    _loginWidget = CircularProgressIndicator();

                    // Error Message
                    _errorMessage = StreamBuilder(
                      stream: Stream.fromFuture(
                        user.signIn(_email, _password),
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            {
                              return Text('Logging in...');
                            }
                          default:
                            {
                              Navigator.pop(context);
                              return Text('Logged In');
                            }
                        }
                      },
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _signIn(String email, String password) {
    return StreamBuilder(
      stream: Stream.fromFuture(user.signIn(email, password)),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              print('Signing In');
              return SizedBox();
            }
          default:
            {
              if (!snapshot.data) {
                // Login failed
                return Text('Email or password is wrong');
              } else {
                // Login success
                return Text('Logged In with id of: ${user.uid}');
              }
            }
        }
      },
    );
  }
}
