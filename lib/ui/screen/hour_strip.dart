import 'package:diary/domain/deed.dart';
import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:diary/ui/screen/small_deed_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourStrip extends StatelessWidget {
  final DateFormat _formatter = DateFormat.Hm();
  late DateTime _time;
  late List<Deed> _deedsOfHour;

  HourStrip(int hour, this._deedsOfHour) {
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
                right: -4,
                top: -4,
                child: IconButton(
                  iconSize: hourStripHeight / 1.5,
                  icon: Icon(
                    Icons.add_circle_outline,
                  ),
                  color: darkAppColor,
                  onPressed: () {},
                ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
