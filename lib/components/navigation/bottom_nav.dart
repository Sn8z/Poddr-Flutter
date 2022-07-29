import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/router_service.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    String location = ref.read(routerProvider).location;

    void _updateLocation(String location) {
      context.go(location);
    }

    return Container(
      width: screenWidth,
      height: 60,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 35, 35, 35),
        backgroundBlendMode: BlendMode.multiply,
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
            iconSize: location == '/' ? 36 : 28,
            onPressed: () => _updateLocation('/'),
            icon: location == '/'
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [Colors.orange, Colors.deepOrange],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: const Icon(Icons.podcasts_outlined),
                  )
                : const Icon(Icons.podcasts),
          ),
          IconButton(
            iconSize: location == '/search' ? 36 : 28,
            onPressed: () => _updateLocation('/search'),
            icon: location == '/search'
                ? const Icon(
                    Icons.search,
                    color: Colors.blue,
                  )
                : const Icon(Icons.search),
          ),
          IconButton(
            iconSize: location == '/favourites' ? 36 : 28,
            onPressed: () => _updateLocation('/favourites'),
            icon: location == '/favourites'
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite),
          ),
          IconButton(
            iconSize: location == '/settings' ? 36 : 28,
            onPressed: () => _updateLocation('/settings'),
            icon: location == '/settings'
                ? const Icon(
                    Icons.settings,
                    color: Colors.yellow,
                  )
                : const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
