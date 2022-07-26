import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    void _updateLocation(String location) {
      context.go(location);
    }

    return Container(
      width: screenWidth,
      height: 60,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 35, 35, 35),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 28,
            onPressed: () => _updateLocation('/'),
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Colors.orange, Colors.deepOrange],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(Icons.podcasts_outlined),
            ),
          ),
          IconButton(
            iconSize: 28,
            onPressed: () => _updateLocation('/search'),
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.blueAccent],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(Icons.search),
            ),
          ),
          IconButton(
            iconSize: 28,
            onPressed: () => _updateLocation('/favourites'),
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Colors.redAccent, Colors.red],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(Icons.favorite),
            ),
          ),
          IconButton(
            iconSize: 28,
            onPressed: () => _updateLocation('/settings'),
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Colors.yellow, Colors.yellowAccent],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}
