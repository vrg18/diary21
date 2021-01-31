import 'package:diary/domain/user.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loginController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: Colors.lightGreen[200],
            padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(30.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    child: Text(loginPress, style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      String error = await context.read<User>().login(_loginController.text, _passwordController.text);
                      if (error.isNotEmpty) {
                        print('Ошибка 2: $error');
                        _showMessage(context, error);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
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
