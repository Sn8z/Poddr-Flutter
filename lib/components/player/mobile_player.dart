import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class MobilePlayer extends ConsumerWidget {
  const MobilePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);
    double playerProgress =
        player.position.inSeconds.toInt() / player.duration.inSeconds.toInt();
    playerProgress = playerProgress.isNaN ? 0.0 : playerProgress;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(180, 25, 25, 25),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8.0,
            sigmaY: 8.0,
          ),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: playerProgress,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      player.isPlaying
                          ? IconButton(
                              onPressed: () {
                                ref.read(playbackProvider.notifier).pause();
                              },
                              icon: const Icon(Icons.pause_circle),
                            )
                          : IconButton(
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
                  Column(
                    children: [
                      Text(
                        player.currentPodcast,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(player.currentEpisode),
                    ],
                  ),
                  Image.network(
                    'https://podmestorage.blob.core.windows.net/podcast-images/F9378BFC404B1498E9E491524DDA7A2C_medium.jpg',
                    fit: BoxFit.fitHeight,
                    height: 70,
                  ),

                  // const FlutterLogo()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
