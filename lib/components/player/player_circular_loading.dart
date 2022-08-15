import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/audio_service.dart';

class PlayerCircularLoading extends ConsumerWidget {
  const PlayerCircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(playbackProvider.select((value) => value.isLoading));
    return Visibility(
      visible: isLoading,
      child: const SizedBox(
        height: 60,
        width: 60,
        child: CircularProgressIndicator(
          strokeWidth: 6.0,
        ),
      ),
    );
  }
}
