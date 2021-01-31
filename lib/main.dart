import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:diary/domain/user.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/res/theme.dart';
import 'package:diary/ui/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(
      DevicePreview(
        enabled: isWeb(),
        devices: [Devices.android.samsungS8],
        defaultDevice: Devices.android.samsungS8,
        isToolbarVisible: true,
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider<User>(create: (_) => User()),
          ],
          child: MyApp(),
        ),
      ),
    );

/// Приложение запущено в WEB?
bool isWeb() {
  bool _isWeb;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      _isWeb = false;
    } else {
      _isWeb = true;
    }
  } catch (e) {
    _isWeb = true;
  }
  return _isWeb;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: appTitle,
      theme: mainTheme,
      home: LoginScreen(),
    );
  }
}
