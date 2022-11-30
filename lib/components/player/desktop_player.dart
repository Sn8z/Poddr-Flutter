import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/player/current_episode.dart';
import 'package:poddr/components/player/current_podcast.dart';
import 'package:poddr/components/player/duration.dart';
import 'package:poddr/components/player/player_circular_loading.dart';
import 'package:poddr/components/player/player_play_button.dart';
import 'package:poddr/components/player/player_progress_slider.dart';
import 'package:poddr/components/player/player_volume_slider.dart';
import 'package:poddr/components/player/position.dart';
import 'package:poddr/services/audio_service.dart';
import 'package:universal_platform/universal_platform.dart';

class DesktopPlayer extends StatelessWidget {
  const DesktopPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 15, 15, 15)
            : Colors.grey[200],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          const PlayerProgressSlider(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CurrentPodcastText(),
                      const CurrentEpisodeText(),
                      Row(
                        children: const [
                          PositionTimer(),
                          Text(' / '),
                          DurationTimer(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.fast_rewind),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: const [
                          PlayerCircularLoading(),
                          PlayerPlayButton(),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.fast_forward),
                      ),
                    ],
                  ),
                ),
                if (UniversalPlatform.isWeb | UniversalPlatform.isDesktop)
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.volume_down_outlined),
                        PlayerVolumeSlider(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
