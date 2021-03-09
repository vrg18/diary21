import 'package:diary/data/repository/current_day.dart';
import 'package:diary/data/repository/current_user.dart';
import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/widget/hour_strip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _scrollController = ScrollController(initialScrollOffset: startingOffsetOfListOfHourStripes);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            locale: 'ru_RU',
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: weekendColor),
            ),
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(color: weekendColor),
            ),
            availableCalendarFormats: {
              CalendarFormat.month: monthTitle,
              CalendarFormat.twoWeeks: twoWeeksTitle,
              CalendarFormat.week: weekTitle,
            },
            selectedDayPredicate: (day) => _selectedDay == day,
            onDaySelected: (selectedDay, focusedDay) => setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              context.read<CurrentDay>().readDeedsOfDayByHour(selectedDay);
            }),
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: context
                  .watch<CurrentDay>()
                  .deedsOfDayByHour
                  .entries
                  .map((e) => HourStrip(e.key, e.value, _selectedDay))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
