import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/services/router_service.dart';
import 'menu_items.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: menuItems.map((m) {
          final bool isActive = location == m.path;
          return IconButton(
            iconSize: 32,
            tooltip: m.title,
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
    );
  }
}
