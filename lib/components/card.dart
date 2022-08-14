import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardComponent extends ConsumerStatefulWidget {
  const CardComponent({
    Key? key,
    this.title = '',
    this.subtitle = '',
    required this.onTap,
    this.imgUrl,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final void Function() onTap;
  final String? imgUrl;

  @override
  ConsumerState<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends ConsumerState<CardComponent> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInExpo,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isHovered
                ? Theme.of(context).backgroundColor
                : Colors.transparent,
            boxShadow: isHovered
                ? const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black,
                      blurStyle: BlurStyle.outer,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ]
                : null,
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.imgUrl ?? "https://picsum.photos/300",
                fit: BoxFit.contain,
                errorWidget: (context, url, error) {
                  return Image.asset('assets/images/placeholder.png');
                },
                placeholder: (context, url) {
                  return const CircularProgressIndicator();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (isHovered)
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_rounded),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
