import 'package:diary/data/repository/current_user.dart';
import 'package:diary/data/repository/is_web.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/res/theme.dart';
import 'package:diary/ui/screen/calendar.dart';
import 'package:diary/ui/screen/login_screen.dart';
import 'package:diary/ui/screen/shell_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        Provider<Web>(create: (_) => Web()),
        Provider<CurrentUser>(create: (_) => CurrentUser()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('ru', 'RU'),
        title: appTitle,
        theme: mainTheme,
//        builder: (_, __) => ShellScreens(LoginScreen()),
        builder: (_, __) => ShellScreens(Calendar()),
      ),
    );
  }
}
