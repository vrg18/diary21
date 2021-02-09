import 'package:diary/ui/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

main() => initializeDateFormatting().then((_) => runApp(MyApp()));
