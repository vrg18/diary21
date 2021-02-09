import 'package:diary/data/repository/current_user.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo Provider.of<CurrentUser>(context, listen: false).user.email)),
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'grig1e@mail.ru',
            style: TextStyle(fontSize: 12),
          ),
        ),
        toolbarHeight: appBarHeight,
      ),
      body: TableCalendar(
        calendarController: _calendarController,
        locale: 'ru_RU',
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableCalendarFormats: {
          CalendarFormat.week: 'Неделя',
          CalendarFormat.twoWeeks: '2 недели',
          CalendarFormat.month: 'Месяц',
        },
      ),
    );
  }
}
