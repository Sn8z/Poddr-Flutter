import 'package:flutter/material.dart';
import 'package:poddr/components/player/desktop_player.dart';
import 'package:poddr/components/player/mobile_player.dart';

// Components & Helpers
import 'package:poddr/helpers/breakpoints.dart';
import 'package:poddr/components/navigation/bottom_nav.dart';
import 'package:poddr/components/navigation/sidenav.dart';
import 'package:poddr/components/navigation/siderail.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > Breakpoints.desktopScreen) {
              return Row(
                children: [
                  const SideNav(),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: child,
                          flex: 1,
                        ),
                        DesktopPlayer(),
                      ],
                    ),
                  ),
                ],
              );
            } else if (constraints.maxWidth > Breakpoints.tabletScreen) {
              return Row(
                children: [
                  const SideRail(),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: child),
                        DesktopPlayer(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(child: child),
                  const MobilePlayer(),
                  const BottomNav(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
