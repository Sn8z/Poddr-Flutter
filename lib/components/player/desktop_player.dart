import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';
import 'package:universal_platform/universal_platform.dart';

class DesktopPlayer extends ConsumerWidget {
  const DesktopPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);

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
            Visibility(
              visible: player.isLoading,
              child: const LinearProgressIndicator(
                minHeight: 4.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      player.isPlaying
                          ? IconButton(
                              iconSize: 52,
                              onPressed: () {
                                ref.read(playbackProvider.notifier).pause();
                              },
                              icon: const Icon(Icons.pause_circle_rounded),
                            )
                          : IconButton(
                              iconSize: 52,
                              onPressed: () {
                                ref.read(playbackProvider.notifier).play();
                              },
                              icon: const Icon(Icons.play_circle_rounded),
                            ),
                      Visibility(
                        visible: player.isLoading,
                        child: const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator(
                            strokeWidth: 6.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Slider(
                          min: 0.0,
                          max: player.duration.inSeconds.toDouble(),
                          value: player.position.inSeconds.toDouble(),
                          onChangeStart: (_) {
                            ref.read(playbackProvider.notifier).pause();
                          },
                          onChangeEnd: (_) {
                            ref.read(playbackProvider.notifier).play();
                          },
                          onChanged: (double v) {
                            ref.read(playbackProvider.notifier).seek(v.toInt());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(player.getPosition()),
                            Text(player.getDuration()),
                          ],
                        ),
                        Text(player.currentPodcast),
                        Text(player.currentEpisode),
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
                      children: [
                        const Icon(Icons.volume_up_rounded),
                        Slider(
                          min: 0.0,
                          max: 1.0,
                          value: player.volume,
                          onChanged: (double v) {
                            debugPrint("Setting volume to $v");
                            ref.read(playbackProvider.notifier).setVolume(v);
                          },
                        ),
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
