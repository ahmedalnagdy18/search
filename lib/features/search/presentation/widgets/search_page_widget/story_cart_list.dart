import 'package:flutter/material.dart';

class StoryCartList extends StatelessWidget {
  const StoryCartList({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            const CircleAvatar(
              maxRadius: 30,
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.1395880969.1710201600&semt=ais"),
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
        const Text("price : 30"),
      ],
    );
  }
}
