import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/router_service.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    final String currentLocation = ref.read(routerProvider).location;

    void _updateLocation(String location) {
      context.go(location);
    }

    return Container(
      width: screenWidth,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(currentLocation),
          IconButton(
            onPressed: () => _updateLocation('/'),
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () => _updateLocation('/search'),
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => _updateLocation('/favourites'),
            icon: const Icon(Icons.heart_broken),
          ),
          IconButton(
            iconSize: 42,
            onPressed: () => _updateLocation('/settings'),
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Colors.orange, Colors.grey],
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
