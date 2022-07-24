import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class MobilePlayer extends ConsumerWidget {
  const MobilePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text(player.currentPodcast),
              const Text(" - "),
              Text(player.currentEpisode),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.green,
                    thumbColor: Colors.red,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: player.duration.inSeconds.toDouble(),
                    value: player.position.inSeconds.toDouble(),
                    onChanged: (double v) {
                      ref.read(playbackProvider.notifier).seek(v.toInt());
                    },
                    onChangeStart: (_) {},
                    onChangeEnd: (_) {},
                  ),
                ),
              ),
            ],
          ),
          Row(children: [
            IconButton(
              onPressed: () {
                ref.read(playbackProvider.notifier).play();
              },
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                ref.read(playbackProvider.notifier).pause();
              },
              icon: const Icon(Icons.pause_circle),
            ),
            Text(player.isPlaying.toString()),
            Text(player.duration.toString()),
            Text(player.position.toString()),
          ]),
        ],
      ),
    );
  }
}
