import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PlayerProgressSlider extends ConsumerWidget {
  const PlayerProgressSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playbackProvider);
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[400],
        trackShape: const RectangularSliderTrackShape(),
        trackHeight: 6.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
        thumbColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[200]
            : Colors.grey[300],
        overlayColor: Colors.white.withAlpha(32),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18.0),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.grey[500],
        inactiveTickMarkColor: Colors.grey[200],
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.grey[600],
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
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
    );
  }
}
