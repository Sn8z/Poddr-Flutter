import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:poddr/services/audio_service.dart';

class SideNav extends StatefulWidget {
  const SideNav({Key? key}) : super(key: key);

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  @override
  Widget build(BuildContext context) {
    String currentLocation = GoRouter.of(context).location;

    void _updateLocation(String location) {
      context.go(location);
    }

    return Container(
      width: 250,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 30, 30, 30)
            : const Color.fromARGB(255, 200, 200, 200),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: MoveWindow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Poddr",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]
                      : Colors.grey[700],
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'PODCASTS',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Charts",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.list),
                  selected: currentLocation == "/charts" ? true : false,
                  onTap: () => _updateLocation('/charts'),
                ),
                ListTile(
                  title: const Text(
                    "Search",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.search),
                  selected: currentLocation == "/search" ? true : false,
                  onTap: () => _updateLocation('/search'),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]
                      : Colors.grey[700],
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'LIBRARY',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Favourites",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.favorite),
                  selected: currentLocation == "/favourites" ? true : false,
                  onTap: () => _updateLocation('/favourites'),
                ),
                ListTile(
                  title: const Text(
                    "Playlists",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.playlist_add_check),
                  selected: currentLocation == "/favourites" ? true : false,
                  onTap: () => _updateLocation('/favourites'),
                ),
                ListTile(
                  title: const Text(
                    "Downloads",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.download_done),
                  selected: currentLocation == "/favourites" ? true : false,
                  onTap: () => _updateLocation('/favourites'),
                ),
                Divider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]
                      : Colors.grey[700],
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.settings),
                  selected: currentLocation == "/settings" ? true : false,
                  onTap: () => _updateLocation('/settings'),
                ),
              ],
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
