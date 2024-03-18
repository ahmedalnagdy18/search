import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.text,
      required this.backgroundImage,
      required this.textButton});
  final void Function()? onPressed;
  final Color? color;
  final String text;
  final String textButton;
  final ImageProvider<Object>? backgroundImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: backgroundImage,
                  backgroundColor: Colors.white,
                ),
                Text(
                  text,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: onPressed,
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(0.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 80, minHeight: 40),
              alignment: Alignment.center,
              child: Text(
                textButton,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
