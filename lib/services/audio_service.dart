import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';

final playerProvider = Provider<AudioPlayer>((ProviderRef ref) {
  return AudioPlayer();
});

class PlaybackState {
  PlaybackState({
    this.isPlaying = false,
    this.isLoading = false,
    this.volume = 0.8,
    this.playbackRate = 1.0,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.currentEpisode = "Episode",
    this.currentPodcast = "Podcast",
  });

  final bool isPlaying;
  final bool isLoading;
  final double volume;
  final double playbackRate;
  final Duration duration;
  final Duration position;
  final String currentEpisode;
  final String currentPodcast;

  PlaybackState copyWith({
    bool? isPlaying,
    bool? isLoading,
    double? volume,
    double? playbackRate,
    Duration? duration,
    Duration? position,
    String? currentEpisode,
    String? currentPodcast,
  }) {
    return PlaybackState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      volume: volume ?? this.volume,
      playbackRate: playbackRate ?? this.playbackRate,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      currentPodcast: currentPodcast ?? this.currentPodcast,
    );
  }
}

class PlaybackNotifier extends StateNotifier<PlaybackState> {
  final AudioPlayer player;

  PlaybackNotifier(this.player) : super(PlaybackState()) {
    print('PlaybackNotifier init!');
    setupAudioSession();
    initPlayer();
  }

  void setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  void initPlayer() async {
    await player.setVolume(state.volume);
    await player.setLoopMode(LoopMode.off);
    await player.setSpeed(state.playbackRate);

    loadAudio(
        podcast: 'Avicii',
        episode: 'Episode 03',
        url:
            'https://media.rawvoice.com/officialaviciipodcast/media2-av.podtree.com/media/podcast/AVICII_FM_008.m4a');

    player.durationStream.listen((Duration? dur) {
      print('Max duration: $dur');
      state = state.copyWith(duration: dur);
    });

    player.positionStream.listen((Duration? pos) {
      print('Current position: $pos');
      state = state.copyWith(position: pos);
    });

    player.playerStateStream.listen((PlayerState playerState) {
      if (playerState.playing) {
        print('Player is Playing!');
        state = state.copyWith(isPlaying: true);
      } else {
        state = state.copyWith(isPlaying: false);
      }

      switch (playerState.processingState) {
        case ProcessingState.idle:
          print('Player is Idle!');
          break;
        case ProcessingState.loading:
          print('Player is Loading!');
          state = state.copyWith(isLoading: true);
          break;
        case ProcessingState.buffering:
          print('Player is Buffering!');
          state = state.copyWith(isLoading: true);
          break;
        case ProcessingState.ready:
          print('Player is Ready!');
          state = state.copyWith(isLoading: false);
          break;
        case ProcessingState.completed:
          print('Player is Completed!');
          state = state.copyWith(
            isPlaying: false,
            position: Duration.zero,
          );
          break;
        default:
          break;
      }
    });

    player.playbackEventStream.listen((PlaybackEvent event) {
      print(event);
    }, onError: (Object e, StackTrace st) {
      player.stop();
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
      return 0;
    });
  }

  void loadAudio(
      {String podcast = "Podcast",
      String episode = "Episode",
      required String url}) async {
    try {
      state = state.copyWith(
        currentPodcast: podcast,
        currentEpisode: episode,
      );
      final AudioSource audioSource = AudioSource.uri(Uri.parse(url),
          tag: MediaItem(
            id: '1',
            title: episode,
            album: podcast,
            artist: 'Poddr',
            artUri: Uri.parse(
                'https://podmestorage.blob.core.windows.net/podcast-images/F9378BFC404B1498E9E491524DDA7A2C_medium.jpg'),
          ));
      await player.setAudioSource(audioSource);
    } on PlayerException catch (e) {
      print("Error code: ${e.code}");
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print('An error occured: $e');
    }
  }

  void play() async {
    player.play();
  }

  void pause() async {
    print('AudioService pausing');
    await player.pause();
  }

  void stop() async {
    print('AudioService stopping');
    await player.stop();
  }

  void seek(int seekPos) async {
    print('AudioService seeking');
    try {
      await player.seek(Duration(seconds: seekPos));
    } catch (e) {
      print(e.toString());
    }
  }

  void setSpeed(double rate) async {
    print('AudioService setting speed');
    await player.setSpeed(rate);
    state = state.copyWith(playbackRate: rate);
  }

  void setVolume(double volume) async {
    print('AudioService setting volume');
    await player.setVolume(volume);
    state = state.copyWith(volume: volume);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

final playbackProvider =
    StateNotifierProvider<PlaybackNotifier, PlaybackState>((ref) {
  final player = ref.watch(playerProvider);
  return PlaybackNotifier(player);
});
