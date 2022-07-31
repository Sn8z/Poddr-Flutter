import 'package:flutter/material.dart';

class CustomMenuItem {
  CustomMenuItem(this.title, this.path, this.icon);

  final String title;
  final String path;
  final IconData icon;
}

List<CustomMenuItem> menuItems = [
  CustomMenuItem('Charts', '/', Icons.podcasts_rounded),
  CustomMenuItem('Favourites', '/favourites', Icons.favorite_rounded),
  CustomMenuItem('Search', '/search', Icons.search_rounded),
  CustomMenuItem('Settings', '/settings', Icons.settings_rounded),
];
