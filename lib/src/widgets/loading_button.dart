import 'dart:async';

import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String description;
  final FutureOr Function() onPressed;
  const LoadingButton({Key? key, required this.description, required this.onPressed}) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  void changeState() async {
    setState(() {
      isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: isLoading ? 50 : 60,
      width: isLoading ? 70 : 180,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.green;
          }
          return Colors.blue;
        })),
        onPressed: isLoading ? null : changeState,
        child: isLoading ? const CircularProgressIndicator(color: color) : Text(widget.description),
      ),
    );
  }
}
