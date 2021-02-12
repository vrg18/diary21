import 'package:diary/data/repository/current_user.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/screen/calendar.dart';
import 'package:diary/ui/screen/shell_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool _isLoading;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _loginController.text = 'grig1e@mail.ru';
    _passwordController.text = 'nik210207';
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = context.read<CurrentUser>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(basicBorderSize),
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
                        String error = await _currentUser.login(_loginController.text, _passwordController.text);
                        if (error.isNotEmpty) {
                          _showMessage(context, error);
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (_) => ShellScreens(Calendar())), (_) => false);
                        }
                      } else {
                        _showMessage(context, loginAndPassEmpty);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    child: Text(loginGooglePress),
                    onPressed: () async {
                      setState(() => (_isLoading = true));
                      String error = await _currentUser.googleLogin();
                      if (error.isNotEmpty) {
                        _showMessage(context, error);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (_) => ShellScreens(Calendar())), (_) => false);
                      }
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
