import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:poddr/components/player/current_episode.dart';
import 'package:poddr/components/player/current_podcast.dart';
import 'package:poddr/components/player/duration.dart';
import 'package:poddr/components/player/player_circular_loading.dart';
import 'package:poddr/components/player/player_play_button.dart';
import 'package:poddr/components/player/player_progress_slider.dart';
import 'package:poddr/components/player/player_volume_slider.dart';
import 'package:poddr/components/player/position.dart';
import 'package:universal_platform/universal_platform.dart';

class DesktopPlayer extends StatelessWidget {
  const DesktopPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(180, 30, 30, 30)
            : const Color.fromARGB(180, 220, 220, 220),
      ),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      PlayerCircularLoading(),
                      PlayerPlayButton(),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: const [
                              CurrentPodcastText(),
                              Text(' - '),
                              CurrentEpisodeText(),
                            ],
                          ),
                        ),
                        const PlayerProgressSlider(),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              PositionTimer(),
                              DurationTimer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (UniversalPlatform.isWeb | UniversalPlatform.isDesktop)
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        PlayerVolumeSlider(),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
