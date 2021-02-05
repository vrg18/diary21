import 'package:diary/domain/user.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    final _loginController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: Colors.grey,
            padding: constraints.maxWidth < 600
                ? EdgeInsets.zero
                : const EdgeInsets.all(30.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(greetingString, style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _loginController,
                    decoration: InputDecoration(labelText: loginHint),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: passwordHint),
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    child: Text(loginPress),
                    // style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      String error = await context.read<User>().login(
                          _loginController.text, _passwordController.text);
                      if (error.isNotEmpty) {
                        print('Ошибка 2: $error');
                        _showMessage(context, error);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    child: Text(loginGooglePress),
                    // style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      _googleLogin();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _googleLogin() async {
    try {
      GoogleSignInAccount user = (await _googleSignIn.signIn())!;
      GoogleSignInAuthentication googleSignInAuthentication =
          await user.authentication;
      print(googleSignInAuthentication.accessToken);
    } catch (error) {
      print(error);
    }
  }

  Future _showMessage(BuildContext context, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
