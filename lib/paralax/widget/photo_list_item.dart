import 'package:flutter/material.dart';

class PhotoListItem extends StatelessWidget {
  final int id;

  const PhotoListItem({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      clipBehavior: Clip.hardEdge,
      width: double.maxFinite,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Image.network(
            'https://picsum.photos/id/$id/500/300',
            width: double.maxFinite,
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: Text(
              'Image $id',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
