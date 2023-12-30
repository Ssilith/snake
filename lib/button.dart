import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const MyButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 130,
        child: ElevatedButton(
            onPressed: () => onPressed(),
            child: Text(title,
                style: const TextStyle(fontSize: 16, color: Colors.black))));
  }
}
