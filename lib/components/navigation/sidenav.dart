import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideNav extends StatefulWidget {
  const SideNav({Key? key}) : super(key: key);

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    String currentLocation = GoRouter.of(context).location;

    void _updateLocation(String location) {
      context.go(location);
      setState(() {
        currentLocation = GoRouter.of(context).location;
      });
    }

    return SizedBox(
      width: screenWidth / 5,
      height: screenHeight,
      child: ListView(
        children: [
          ListTile(
            title: const Text("Toplists"),
            leading: const Icon(Icons.list),
            selected: currentLocation == "/" ? true : false,
            selectedTileColor: Theme.of(context).primaryColor,
            onTap: () => _updateLocation('/'),
          ),
          ListTile(
            title: const Text("Search"),
            leading: const Icon(Icons.search),
            selected: currentLocation == "/search" ? true : false,
            selectedTileColor: Theme.of(context).primaryColor,
            onTap: () => _updateLocation('/search'),
          ),
          ListTile(
            title: const Text("Favourites"),
            leading: const Icon(Icons.favorite),
            selected: currentLocation == "/favourites" ? true : false,
            selectedTileColor: Theme.of(context).primaryColor,
            onTap: () => _updateLocation('/favourites'),
          ),
          ListTile(
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            selected: currentLocation == "/settings" ? true : false,
            selectedTileColor: Theme.of(context).primaryColor,
            onTap: () => _updateLocation('/settings'),
          ),
          Center(child: Text(currentLocation)),
        ],
      ),
    );
  }
}
