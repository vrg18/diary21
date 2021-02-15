import 'package:diary/domain/deed.dart';
import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:diary/ui/screen/details.dart';
import 'package:diary/ui/screen/shell_screens.dart';
import 'package:diary/ui/widget/small_deed_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourStrip extends StatelessWidget {
  final DateFormat _formatter = DateFormat.Hm();
  late DateTime _time;
  late List<Deed> _deedsOfHour;
  late DateTime _selectedDay;

  HourStrip(int hour, this._deedsOfHour, this._selectedDay) {
    this._time = DateTime(0, 0, 0, hour, 0, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: basicBorderSize / 2, vertical: distanceBetweenStripesOfAnHour / 2),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: hourStripHeight,
          color: secondaryAppColor,
          child: Stack(
            children: [
              Row(
                children: [
                  SizedBox(width: 8),
                  Text(_formatter.format(_time)),
                  SizedBox(width: 8),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _deedsOfHour.map((e) => SmallDeedCard(e)).toList(),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: -6,
                top: -5,
                child: IconButton(
                  iconSize: hourStripHeight / 1.5,
                  icon: Icon(
                    Icons.add_circle_outline,
                  ),
                  color: darkAppColor,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ShellScreens(Details(
                          newDeedStartDate: DateTime(
                              _selectedDay.year, _selectedDay.month, _selectedDay.day, _time.hour, 0, 0, 0, 0))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
