import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {

  final String text;
  final void Function() onTap;

  const AuthButton({super.key, required this.text, required this.onTap});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // TODO sign in,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.deepPurple[200],
            borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
      ),
    );
  }
}
