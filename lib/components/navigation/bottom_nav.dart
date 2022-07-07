import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    String currentLocation = GoRouter.of(context).location;

    void _updateLocation(String location) {
      context.go(location);
      setState(() {
        currentLocation = GoRouter.of(context).location;
      });
    }

    return Container(
      width: screenWidth,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
