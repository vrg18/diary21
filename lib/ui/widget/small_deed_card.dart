import 'package:diary/data/repository/deed_briefly.dart';
import 'package:diary/domain/deed.dart';
import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:diary/ui/screen/details.dart';
import 'package:diary/ui/screen/shell_screens.dart';
import 'package:flutter/material.dart';

class SmallDeedCard extends StatelessWidget {
  final Deed _deed;

  SmallDeedCard(this._deed);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Container(
        margin: const EdgeInsets.all(4),
        color: appButtonColor,
        child: Stack(
          children: [
            Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: SizedBox.expand(
                      child: Image.asset(
                        smallPicture,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  DeedBriefly(_deed).inscription,
//                style: sightMiniCardTitleStyle,
                ),
              ],
            ),
            Positioned.fill(
              child: MaterialButton(
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ShellScreens(Details(deed: _deed)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
