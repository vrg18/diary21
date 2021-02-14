import 'package:diary/data/repository/current_day.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<CurrentUser>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Center(
          child: Text(
            greetingString,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(height: 2, child: _isLoading ? LinearProgressIndicator() : null),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox.expand(
                          child: Image.asset(
                            'lib/ui/res/21_large.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
//                  Expanded(child: Text(greetingString, style: TextStyle(fontSize: 20))),
//                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 30),
                        child: TextField(
                          controller: _loginController,
                          decoration: InputDecoration(
                            hintText: loginHint,
                            icon: Icon(Icons.mail),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 30),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: passwordHint,
                            icon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                    ),
                  ),
//                  const SizedBox(height: 25),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 30),
                        child: RaisedButton(
                          child: Text(loginPress),
                          onPressed: () async {
                            if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                              setState(() => (_isLoading = true));
                              String error = await currentUser.login(_loginController.text, _passwordController.text);
                              if (error.isNotEmpty) {
                                _showMessage(context, error);
                              } else {
                                context.read<CurrentDay>().initDeedStorage(currentUser.user.token);
                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (_) => ShellScreens(Calendar())), (_) => false);
                              }
                            } else {
                              _showMessage(context, loginAndPassEmpty);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
//                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 30),
                        child: RaisedButton(
                          child: Text(loginGooglePress),
                          onPressed: () async {
                            setState(() => (_isLoading = true));
                            String error = await currentUser.googleLogin();
                            if (error.isNotEmpty) {
                              _showMessage(context, error);
                            } else {
                              context.read<CurrentDay>().initDeedStorage(currentUser.user.token);
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (_) => ShellScreens(Calendar())), (_) => false);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
//                  const SizedBox(height: 10),
                  Expanded(
                    child: FlatButton(
                      child: Text(loginCreatePress),
                      onPressed: () async {
                        if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                          setState(() => (_isLoading = true));
                          String message =
                              await currentUser.createLogin(_loginController.text, _passwordController.text);
                          if (message.isNotEmpty) _showMessage(context, message);
                        } else {
                          _showMessage(context, loginAndPassEmpty);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Text(loginForgotPress),
                      onPressed: () async {
                        if (_loginController.text.isNotEmpty) {
                          setState(() => (_isLoading = true));
                          String message = await currentUser.forgotLogin(_loginController.text);
                          if (message.isNotEmpty) _showMessage(context, message);
                        } else {
                          _showMessage(context, loginEmpty);
                        }
                      },
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FlatButton(
        child: Text(
          fillWithTestUserData,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        onPressed: () {
          _loginController.text = loginTestUser;
          _passwordController.text = passwordTestUser;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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
