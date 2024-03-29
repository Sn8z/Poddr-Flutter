import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomSliverBar extends StatelessWidget {
  const CustomSliverBar({
    Key? key,
    required this.title,
    required this.description,
    this.image,
    this.actions = const [],
  }) : super(key: key);
  final List<Widget> actions;
  final String title;
  final String description;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 200.0,
      elevation: 0,
      title: Text(title),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            if (image != null)
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: image!,
                  fit: BoxFit.cover,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 90, 12, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }
}
