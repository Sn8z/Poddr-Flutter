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
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
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
                            children: [
                              Text(
                                player.currentPodcast,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(' - '),
                              Text(
                                player.currentEpisode,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(player.getPosition()),
                              Text(player.getDuration()),
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
