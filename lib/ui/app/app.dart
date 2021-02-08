import 'package:device_preview/device_preview.dart';
import 'package:diary/data/repository/current_user.dart';
import 'package:diary/data/repository/is_web.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/res/theme.dart';
import 'package:diary/ui/screen/login_screen.dart';
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
      builder: (context, _) {
        return DevicePreview(
          enabled: Provider.of<Web>(context, listen: false).isWeb,
          devices: [Devices.android.samsungS8],
          defaultDevice: Devices.android.samsungS8,
          isToolbarVisible: true,
          builder: (_) => MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: appTitle,
            theme: mainTheme,
            home: LoginScreen(),
          ),
        );
      },
    );
  }
}
