import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:math' show Random;

class PageImageBackground extends StatefulWidget {
  const PageImageBackground({
    super.key,
    required this.child,
    required this.scrollController,
  });

  final Widget child;
  final ScrollController scrollController;

  @override
  State<PageImageBackground> createState() => _PageImageBackgroundState();
}

class _PageImageBackgroundState extends State<PageImageBackground> {
  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  ui.Image? _image;

  Future<void> _loadImage() async {
    final imageProvider = NetworkImage(
        'https://picsum.photos/id/${Random().nextInt(500)}/600/4000');
    final ImageStreamListener listener = ImageStreamListener((info, _) {
      setState(() {
        _image = info.image;
      });
    });
    final ImageStream stream =
        imageProvider.resolve(const ImageConfiguration());
    stream.addListener(listener);
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _image != null
          ? _BackgroundImagePainter(widget.scrollController, _image!)
          : null,
      child: widget.child,
    );
  }
}

class _BackgroundImagePainter extends CustomPainter {
  final ScrollController controller;
  final ui.Image image;

  const _BackgroundImagePainter(
    this.controller,
    this.image,
  ) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();
    final aspectRatio = imageWidth / imageHeight;

    final src = Rect.fromLTWH(
      0,
      0,
      imageWidth,
      imageHeight,
    );
    final deltaY = -controller.offset * 0.1;
    var dst = Rect.fromLTWH(
      0,
      deltaY,
      size.width,
      size.height / aspectRatio,
    );
    canvas.drawImageRect(
      image,
      src,
      dst,
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(_BackgroundImagePainter oldDelegate) =>
      controller.offset != oldDelegate.controller.offset;
}
