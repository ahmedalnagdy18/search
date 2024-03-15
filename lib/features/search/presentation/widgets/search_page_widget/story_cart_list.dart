import 'package:flutter/material.dart';

class StoryCartList extends StatelessWidget {
  const StoryCartList(
      {super.key,
      required this.onTap,
      required this.backgroundImage,
      required this.title});
  final void Function()? onTap;
  final ImageProvider<Object>? backgroundImage;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              maxRadius: 30,
              backgroundImage: backgroundImage,
              backgroundColor: Colors.cyanAccent,
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: const Icon(Icons.close, color: Colors.white, size: 15),
              ),
            ),
          ],
        ),
        Text(title),
      ],
    );
  }
}
