import 'package:diary/data/repository/current_user.dart';
import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _isLoading;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = context.read<CurrentUser>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                decoration: BoxDecoration(
                  color: primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    if (_isLoading) LinearProgressIndicator(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(greetingString, style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _loginController,
                            decoration: InputDecoration(
                              labelText: loginHint,
                              icon: Icon(Icons.mail),
                            ),
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: passwordHint,
                              icon: Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: 25),
                          RaisedButton(
                            child: Text(loginPress),
                            onPressed: () async {
                              if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                setState(() => (_isLoading = true));
                                String error =
                                    await _currentUser.login(_loginController.text, _passwordController.text);
                                if (error.isNotEmpty) _showMessage(context, error);
                              } else {
                                _showMessage(context, loginAndPassEmpty);
                              }
                              _showMessage(context, _currentUser.user.email);
                            },
                          ),
                          const SizedBox(height: 20),
                          RaisedButton(
                            child: Text(loginGooglePress),
                            onPressed: () async {
                              setState(() => (_isLoading = true));
                              String error = await _currentUser.googleLogin();
                              if (error.isNotEmpty) _showMessage(context, error);
                              _showMessage(context, _currentUser.user.email);
                            },
                          ),
                          const SizedBox(height: 10),
                          FlatButton(
                            child: Text(loginCreatePress),
                            onPressed: () async {
                              if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                setState(() => (_isLoading = true));
                                String message =
                                    await _currentUser.createLogin(_loginController.text, _passwordController.text);
                                if (message.isNotEmpty) _showMessage(context, message);
                              } else {
                                _showMessage(context, loginAndPassEmpty);
                              }
                            },
                          ),
                          FlatButton(
                            child: Text(loginForgotPress),
                            onPressed: () async {
                              if (_loginController.text.isNotEmpty) {
                                setState(() => (_isLoading = true));
                                String message = await _currentUser.forgotLogin(_loginController.text);
                                if (message.isNotEmpty) _showMessage(context, message);
                              } else {
                                _showMessage(context, loginEmpty);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future _showMessage(BuildContext context, String content) {
    if (_isLoading) setState(() => (_isLoading = false));

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
