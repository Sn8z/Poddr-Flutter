import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/player/current_episode.dart';
import 'package:poddr/components/player/current_podcast.dart';
import 'package:poddr/components/player/player_circular_loading.dart';
import 'package:poddr/components/player/player_play_button.dart';
import 'package:poddr/components/player/player_progress_linear.dart';
import 'package:poddr/services/audio_service.dart';

class MobilePlayer extends ConsumerWidget {
  const MobilePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerImg =
        ref.watch(playbackProvider.select((value) => value.imageUrl));

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
                const PlayerProgressLinear(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CachedNetworkImage(
                        imageUrl: playerImg,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) {
                          return Image.asset('assets/images/placeholder.png');
                        },
                        placeholder: (context, url) {
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CurrentEpisodeText(),
                          CurrentPodcastText(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          PlayerPlayButton(),
                          PlayerCircularLoading(),
                        ],
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
