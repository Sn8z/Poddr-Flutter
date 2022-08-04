import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      child: GestureDetector(
        onTap: () {
          context.push('/player');
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(180, 30, 30, 30)
                : const Color.fromARGB(180, 220, 220, 220),
            borderRadius: const BorderRadius.only(
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
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          player.isPlaying
                              ? IconButton(
                                  onPressed: () {
                                    ref.read(playbackProvider.notifier).pause();
                                  },
                                  icon: const Icon(Icons.pause_rounded),
                                )
                              : IconButton(
                                  onPressed: () {
                                    ref.read(playbackProvider.notifier).play();
                                  },
                                  icon: const Icon(Icons.play_arrow_rounded),
                                ),
                          Visibility(
                              visible: player.isLoading,
                              child: const CircularProgressIndicator()),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CachedNetworkImage(
                        imageUrl: player.imageUrl,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) {
                          return Image.asset('assets/images/placeholder.png');
                        },
                        placeholder: (context, url) {
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
