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
    this.subActions = const [],
  }) : super(key: key);

  final String title;
  final String subtitle;
  final void Function() onTap;
  final String? imgUrl;
  final List<Widget> actions;
  final List<Widget> subActions;

  @override
  ConsumerState<ListItemComponent> createState() => _ListItemComponentState();
}

class _ListItemComponentState extends ConsumerState<ListItemComponent> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
            duration: const Duration(milliseconds: 100),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isHovered
                  ? const Color.fromARGB(255, 35, 35, 35)
                  : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (widget.imgUrl != null)
                    Container(
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CachedNetworkImage(imageUrl: widget.imgUrl!),
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
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              overflow: TextOverflow.fade,
                            ),
                            maxLines: 3,
                          ),
                          Row(
                            children: widget.subActions,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: widget.actions,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
