import 'package:diary/ui/res/colors.dart';
import 'package:diary/ui/res/sizes.dart';
import 'package:flutter/material.dart';

class ShellScreens extends StatelessWidget {
  final Widget _child;

  ShellScreens(this._child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: constraints.maxWidth < wideScreenSizeOver ? EdgeInsets.zero : const EdgeInsets.all(basicBorderSize),
          color: secondaryBackgroundColor,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: wideScreenSizeOver,
                ),
                color: primaryBackgroundColor,
                child: _child,
              ),
            ),
          ),
        );
      },
    );
  }
}
