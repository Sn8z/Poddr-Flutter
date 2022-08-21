import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 60,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 30, 30, 30)
            : const Color.fromARGB(255, 220, 220, 220),
        boxShadow: const [
          BoxShadow(
            offset: Offset(10, 0),
            blurRadius: 12.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
