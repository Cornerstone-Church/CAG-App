import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cag_app/models/user.dart';

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
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                return FlatButton(
                  child: _loginWidget,
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      setState(() {
                        // Change to loading progress
                        _loginWidget = CircularProgressIndicator();

                        // Error Message
                        _errorMessage = StreamBuilder(
                          stream: Stream.fromFuture(
                            model.signIn(_email, _password),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
