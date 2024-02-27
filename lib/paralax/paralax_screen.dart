import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_paralax_background/paralax/widget/backgorund_image_painter.dart';
import 'package:flutter_paralax_background/paralax/widget/photo_list_item.dart';

class ParallaxScreen extends StatefulWidget {
  const ParallaxScreen({super.key});

  @override
  State<ParallaxScreen> createState() => _ParallaxScreenState();
}

class _ParallaxScreenState extends State<ParallaxScreen> {
  final ScrollController controller = ScrollController();
  late final List<int> ids =
      List.generate(30, (index) => Random().nextInt(500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageImageBackground(
        scrollController: controller,
        child: ListView.builder(
          controller: controller,
          itemCount: ids.length,
          itemBuilder: (context, index) {
            final int id = ids[index];
            return PhotoListItem(id: id);
          },
        ),
      ),
    );
  }
}
