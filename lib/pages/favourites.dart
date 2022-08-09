import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/helpers/breakpoints.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Favourites',
                  ),
                  background: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  collapseMode: CollapseMode.pin,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Card(
                      child: ListTile(
                        hoverColor: Colors.red.shade400,
                        leading: const Icon(Icons.podcasts_rounded),
                        title: Text('Item #$index'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow_rounded),
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
