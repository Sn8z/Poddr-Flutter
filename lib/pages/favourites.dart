import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/components/player/desktop_player.dart';
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
                childAspectRatio: 0.8,
                crossAxisCount:
                    constraints.maxWidth > Breakpoints.desktopScreen ? 5 : 4,
                children: List.generate(100, (index) {
                  return Padding(
                    padding: EdgeInsets.all(25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 12.0,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            'https://www.udiscovermusic.com/wp-content/uploads/2017/08/Pink-Floyd-Dark-Side-Of-The-Moon.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            'Item $index',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(100, (index) {
                  return ListTile(
                    title: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    leading: const Icon(Icons.add_a_photo),
                  );
                }),
              ),
            ),
          ],
        );
      }
    });
  }
}
