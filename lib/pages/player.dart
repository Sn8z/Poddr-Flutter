import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/components/player/current_episode.dart';
import 'package:poddr/components/player/current_podcast.dart';
import 'package:poddr/components/player/duration.dart';
import 'package:poddr/components/player/player_circular_loading.dart';
import 'package:poddr/components/player/player_play_button.dart';
import 'package:poddr/components/player/player_progress_slider.dart';
import 'package:poddr/components/player/player_volume_slider.dart';
import 'package:poddr/components/player/position.dart';
import 'package:poddr/services/audio_service.dart';
import 'package:poddr/services/snackbar_service.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:poddr/services/dialog_service.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerImg =
        ref.watch(playbackProvider.select((value) => value.imageUrl));
    final playerPlaybackRate =
        ref.watch(playbackProvider.select((value) => value.playbackRate));
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Theme.of(context).brightness == Brightness.dark
                  ? [Colors.grey.shade900, Colors.grey.shade800]
                  : [Colors.grey.shade300, Colors.grey.shade100],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.canPop() ? context.pop() : context.go('/');
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    IconButton(
                      onPressed: () {
                        context.canPop() ? context.pop() : context.go('/');
                      },
                      icon: const Icon(Icons.more_horiz_rounded),
                    )
                  ],
                ),
              ),
              const CurrentPodcastText(),
              const CurrentEpisodeText(),
              const SizedBox(height: 40),
              Container(
                width: 250,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      blurRadius: 20,
                      spreadRadius: 0,
                      color: Colors.black,
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous_rounded)),
                  Stack(
                    alignment: Alignment.center,
                    children: const [
                      PlayerPlayButton(),
                      PlayerCircularLoading(),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next_rounded)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const PlayerProgressSlider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    PositionTimer(),
                    DurationTimer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        DialogService().dialog(context);
                      },
                      icon: const Icon(Icons.shuffle_rounded),
                    ),
                    Text(playerPlaybackRate.toString()),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          clipBehavior: Clip.hardEdge,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 400,
                              child: ListView.builder(
                                itemCount: 25,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.podcasts_rounded),
                                    title: Text('$index: Podcast episode'),
                                    trailing:
                                        const Icon(Icons.play_arrow_rounded),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.queue_music_rounded),
                    ),
                    IconButton(
                      onPressed: () {
                        SnackbarService().successSnack(context);
                      },
                      icon: const Icon(Icons.favorite_outline_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        SnackbarService().successSnack(context);
                      },
                      icon: const Icon(Icons.bar_chart_rounded),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
