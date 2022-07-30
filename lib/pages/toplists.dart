import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';

class ToplistPage extends ConsumerWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            const Header(
              title: 'Charts',
            ),
            Expanded(
              child: GridView.builder(
                controller: ScrollController(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 15, 15, 15),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        )),
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo.png'),
                        const Text('data'),
                      ],
                    ),
                  );
                },
                itemCount: 300,
              ),
            ),
          ],
        );
      }),
    );
  }
}
