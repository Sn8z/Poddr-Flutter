import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ListItemComponent extends ConsumerStatefulWidget {
  const ListItemComponent({
    Key? key,
    this.title = '',
    this.subtitle = '',
    required this.onTap,
    this.imgUrl,
    this.actions = const [],
  }) : super(key: key);

  final String title;
  final String subtitle;
  final void Function() onTap;
  final String? imgUrl;
  final List<Widget> actions;

  @override
  ConsumerState<ListItemComponent> createState() => _ListItemComponentState();
}

class _ListItemComponentState extends ConsumerState<ListItemComponent> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: MouseRegion(
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
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CachedNetworkImage(
                    imageUrl: widget.imgUrl ?? "https://picsum.photos/300",
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) {
                      return Image.asset('assets/images/placeholder.png');
                    },
                    placeholder: (context, url) {
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: widget.actions,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
