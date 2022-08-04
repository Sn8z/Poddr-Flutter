import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/audio_service.dart';
import 'package:poddr/services/snackbar_service.dart';
import 'package:universal_platform/universal_platform.dart';

class PlayerPage extends ConsumerWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.canPop() ? context.pop() : context.go('/');
                },
                icon: const Icon(Icons.keyboard_arrow_up_rounded),
              ),
              Text(
                player.currentPodcast,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                player.currentEpisode,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
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
                        color: Colors.black)
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
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
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next_rounded)),
                ],
              ),
              const SizedBox(
                height: 20,
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(player.getPosition()),
                    Text(player.getDuration()),
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
                      onPressed: () {},
                      icon: const Icon(Icons.shuffle_rounded),
                    ),
                    Text(player.playbackRate.toString()),
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
                  ],
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
        ),
      ),
    );
  }
}
