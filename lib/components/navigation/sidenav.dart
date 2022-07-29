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

    String currentLocation = GoRouter.of(context).location;

    void _updateLocation(String location) {
      context.go(location);
      setState(() {
        currentLocation = GoRouter.of(context).location;
      });
    }

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).navigationBarTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      height: screenHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                  ),
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
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
            endIndent: 12,
            indent: 12,
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    "Toplists",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.list),
                  selected: currentLocation == "/" ? true : false,
                  onTap: () => _updateLocation('/'),
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
                    "Settings",
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.settings),
                  selected: currentLocation == "/settings" ? true : false,
                  onTap: () => _updateLocation('/settings'),
                ),
                Center(
                  child: Text(
                    currentLocation,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Image.network(
            'https://podmestorage.blob.core.windows.net/podcast-images/F9378BFC404B1498E9E491524DDA7A2C_medium.jpg',
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ],
      ),
    );
  }
}
