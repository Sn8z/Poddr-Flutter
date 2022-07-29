import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideRail extends StatefulWidget {
  const SideRail({Key? key}) : super(key: key);

  @override
  State<SideRail> createState() => _SideRailState();
}

class _SideRailState extends State<SideRail> {
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
      width: 100,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
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
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
            endIndent: 8,
            indent: 8,
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  onPressed: () => _updateLocation('/'),
                  icon: const Icon(Icons.list),
                ),
                IconButton(
                  onPressed: () => _updateLocation('/search'),
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () => _updateLocation('/favourites'),
                  icon: const Icon(Icons.heart_broken),
                ),
                IconButton(
                  onPressed: () => _updateLocation('/settings'),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
          Image.network(
            'https://podmestorage.blob.core.windows.net/podcast-images/F9378BFC404B1498E9E491524DDA7A2C_medium.jpg',
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
