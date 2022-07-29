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
            const Header(
              title: 'Favourites',
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: 0.8,
                crossAxisCount:
                    constraints.maxWidth > Breakpoints.desktopScreen ? 5 : 4,
                children: List.generate(100, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(26),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
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
                            'https://podmestorage.blob.core.windows.net/podcast-images/F9378BFC404B1498E9E491524DDA7A2C_medium.jpg',
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
            const Header(
              title: 'Favourites',
            ),
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
