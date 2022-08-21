import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class CurrentEpisodeText extends ConsumerWidget {
  const CurrentEpisodeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentEpisode =
        ref.watch(playbackProvider.select((value) => value.currentEpisode));
    return Text(
      currentEpisode,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
