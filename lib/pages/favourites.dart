import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/components/card.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Favourites',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.count(
                  controller: ScrollController(),
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount:
                      constraints.maxWidth > Breakpoints.desktopScreen ? 5 : 4,
                  children: List.generate(100, (index) {
                    return CardComponent(
                      title: 'Title',
                      subtitle: 'Music',
                      onTap: () {},
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
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    tooltip: 'Add new entry',
                    onPressed: () {/* ... */},
                  ),
                ],
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
