import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget? widget;
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? onPressedColor;

  const Button({
    this.text = '',
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.onPressedColor,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Center(
        child: widget == null
            ? Text(
                text,
                style: TextStyle(
                  fontSize: 35,
                  color: textColor,
                ),
              )
            : widget,
      ),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: onPressedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
