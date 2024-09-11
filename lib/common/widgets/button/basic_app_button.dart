import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String tittle;
  final double? height;
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.tittle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        tittle,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
