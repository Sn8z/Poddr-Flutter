import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/helpers/breakpoints.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > Breakpoints.tabletScreen) {
        return Column(
          children: [
            const Header(),
            Expanded(
              child: GridView.count(
                crossAxisCount:
                    constraints.maxWidth > Breakpoints.desktopScreen ? 4 : 2,
                children: List.generate(100, (index) {
                  return Center(
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      } else {
        return ListView(
          children: List.generate(100, (index) {
            return ListTile(
              title: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
              leading: const Icon(Icons.add_a_photo),
            );
          }),
        );
      }
    });
  }
}
