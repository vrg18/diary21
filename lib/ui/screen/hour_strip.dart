import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourStrip extends StatelessWidget {
  final int _hour;
  final DateFormat _formatter = DateFormat.Hm();
  late DateTime _time;

  HourStrip(this._hour) {
    this._time = DateTime(0, 0, 0, _hour, 0, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: basicBorderSize / 2, vertical: distanceBetweenStripesOfAnHour / 2),
      child: Material(
//        type: MaterialType.button,
        elevation: 4,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: hourStripHeight,
          color: secondaryAppColor,
          child: Row(
            children: [
              SizedBox(width: 8),
              Text(_formatter.format(_time)),
            ],
          ),
        ),
      ),
    );
  }
}
