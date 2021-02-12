import 'package:diary/data/repository/deed_briefly.dart';
import 'package:diary/domain/deed.dart';
import 'package:flutter/material.dart';

class SmallDeedCard extends StatelessWidget {
  final Deed _deed;

  SmallDeedCard(this._deed);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox.expand(
                    child: Image.asset(
                      '21_little.jpg',
                      fit: BoxFit.cover,
                      // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      //   if (loadingProgress == null) return child;
                      //   return Center(
                      //     child: CircularProgressIndicator(
                      //       value: loadingProgress.expectedTotalBytes != null
                      //           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      //           : null,
                      //     ),
                      //   );
                      // },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                DeedBriefly(_deed).inscription,
//                style: sightMiniCardTitleStyle,
              ),
            ],
          ),
          Positioned.fill(
            child: MaterialButton(
              onPressed: () => {},//Navigator.push(context, MaterialPageRoute(builder: (_) => SightDetail(_sight))),
            ),
          ),
        ],
      ),
    );
  }
}
