import 'package:flutter/material.dart';
import 'package:poddr/components/base.dart';
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
    return BaseWidget(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > Breakpoints.tabletScreen) {
          return Column(
            children: [
              const Header(
                title: 'Favourites',
              ),
              Expanded(
                child: GridView.count(
                  controller: ScrollController(),
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
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                flexibleSpace: Container(
                  color: Colors.amber,
                  child: FloatingActionButton(
                    onPressed: () {
                      debugPrint('FAB clicked');
                    },
                    child: Icon(Icons.plus_one_rounded),
                  ),
                ),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.podcasts_rounded),
                        title: Text('Item #$index'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow_rounded),
                        ),
                      ),
                    );
                  },
                  childCount: 1000,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
