import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/audio_service.dart';
import 'package:poddr/services/router_service.dart';
import 'menu_items.dart';

class SideRail extends ConsumerWidget {
  const SideRail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.of(context).size.height;
    String location = ref.read(routerProvider).location;

    void _updateLocation(String location) {
      context.go(location);
    }

    return Container(
      width: 100,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 30, 30, 30)
            : const Color.fromARGB(255, 200, 200, 200),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: MoveWindow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
            endIndent: 8,
            indent: 8,
          ),
          Expanded(
            child: Column(
              children: menuItems.map((m) {
                final bool isActive = location == m.path;
                return IconButton(
                  iconSize: 32,
                  onPressed: () => _updateLocation(m.path),
                  icon: isActive
                      ? ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.bottomLeft,
                              colors: [Colors.orange, Colors.deepOrange],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child: Icon(m.icon),
                        )
                      : Icon(m.icon),
                );
              }).toList(),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return CachedNetworkImage(
                imageUrl: ref
                    .watch(playbackProvider.select((value) => value.imageUrl)),
                fit: BoxFit.contain,
                errorWidget: (context, url, error) {
                  return Image.asset('assets/images/placeholder.png');
                },
                placeholder: (context, url) {
                  return const CircularProgressIndicator();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
