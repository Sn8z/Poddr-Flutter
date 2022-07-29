import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class DesktopPlayer extends ConsumerWidget {
  const DesktopPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(240, 35, 35, 35),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8.0,
            sigmaY: 8.0,
          ),
          child: Row(
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
                            iconSize: 36,
                            onPressed: () {
                              ref.read(playbackProvider.notifier).pause();
                            },
                            icon: const Icon(Icons.pause_circle),
                          )
                        : IconButton(
                            iconSize: 36,
                            onPressed: () {
                              ref.read(playbackProvider.notifier).play();
                            },
                            icon: const Icon(Icons.play_arrow),
                          ),
                    Visibility(
                        visible: player.isLoading,
                        child: const CircularProgressIndicator()),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
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
        ),
      ),
    );
  }
}
