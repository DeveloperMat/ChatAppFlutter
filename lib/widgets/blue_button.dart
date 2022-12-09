import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  // final VoidCallback onPressed;

  const BlueButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Container(
          height: 55,
          width: double.infinity,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(fontSize: 17),
          ))),
    );
  }
}
