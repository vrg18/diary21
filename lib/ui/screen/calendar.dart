import 'package:diary/data/repository/current_day.dart';
import 'package:diary/data/repository/current_user.dart';
import 'package:diary/domain/deed.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/screen/hour_strip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarController _calendarController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _scrollController = ScrollController(initialScrollOffset: startingOffsetOfListOfHourStripes);
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
        toolbarHeight: appBarHeight,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            Provider.of<CurrentUser>(context, listen: false).user.email,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 2,
            child: context.watch<CurrentDay>().isLoadingNow ? LinearProgressIndicator() : null,
          ),
          TableCalendar(
            calendarController: _calendarController,
            locale: 'ru_RU',
            startingDayOfWeek: StartingDayOfWeek.monday,
            availableCalendarFormats: {
              CalendarFormat.week: weekTitle,
              CalendarFormat.twoWeeks: twoWeeksTitle,
              CalendarFormat.month: monthTitle,
            },
            onDaySelected: (day, _, __) {context.read<CurrentDay>().readDeedsOfDayByHour(day);},
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children:
                  context.watch<CurrentDay>().deedsOfDayByHour.entries.map((e) => HourStrip(e.key, e.value)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
