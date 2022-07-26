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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: playerProgress,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                        child: CircularProgressIndicator()),
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
                  fit: BoxFit.contain,
                  height: 20,
                ),
                // const FlutterLogo()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
