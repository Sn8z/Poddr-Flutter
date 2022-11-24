import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class Titlebar extends StatelessWidget {
  const Titlebar({super.key});

  @override
  Widget build(BuildContext context) {
    final mouseOver = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade800
        : Colors.grey.shade400;

    final mouseDown = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade700
        : Colors.grey.shade500;

    final iconNormal = Theme.of(context).primaryColor;

    final iconMouseOver = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    final buttonColors = WindowButtonColors(
        mouseOver: mouseOver,
        mouseDown: mouseDown,
        iconNormal: iconNormal,
        iconMouseOver: iconMouseOver);

    final closeButtonColors = WindowButtonColors(
        mouseOver: Colors.red.shade700,
        mouseDown: Colors.red.shade900,
        iconNormal: iconNormal,
        iconMouseOver: Colors.white);

    return WindowTitleBarBox(
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.grey.shade300,
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(),
            ),
            MinimizeWindowButton(
              colors: buttonColors,
            ),
            MaximizeWindowButton(
              colors: buttonColors,
            ),
            CloseWindowButton(
              colors: closeButtonColors,
            ),
          ],
        ),
      ),
    );
  }
}
