import 'package:flutter/material.dart';

// Param
class Param {
  bool autofocus;
  bool? showCursor;
  TextEditingController? controller;
  double? height;
  double? fontSize;
  double? letterSpacing;
  Color? textColor;

  Param({
    this.autofocus = false,
    this.showCursor,
    this.controller,
    this.height,
    this.fontSize,
    this.letterSpacing,
    this.textColor,
  });

  Param.ans({this.controller})
      : autofocus = false,
        showCursor = false,
        height = 40,
        fontSize = 35,
        letterSpacing = 1,
        textColor = Colors.grey;

  Param.op({this.controller})
      : autofocus = true,
        showCursor = true,
        height = 85,
        letterSpacing = 5,
        this.fontSize = 60,
        textColor = Colors.black;
}

class TextFieldTweenAnimation extends StatelessWidget {
  final Param param;
  static Duration duration = Duration(seconds: 1);

  TextFieldTweenAnimation({required this.param});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween<double>(begin: param.height, end: param.height),
      curve: Curves.fastOutSlowIn,
      builder: (context, height, child) {
        return Container(
          height: height,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            reverse: true,
            children: [
              TweenAnimationBuilder<double>(
                duration: duration,
                tween:
                    Tween<double>(begin: param.fontSize, end: param.fontSize),
                curve: Curves.fastOutSlowIn,
                builder: (context, fontSize, child) {
                  return TweenAnimationBuilder<double>(
                    duration: duration,
                    tween: Tween<double>(
                        begin: param.letterSpacing, end: param.letterSpacing),
                    curve: Curves.fastOutSlowIn,
                    builder: (context, letterSpacing, child) {
                      return Container(
                        width: 1000,
                        alignment: Alignment.centerRight,
                        child: TextField(
                          autofocus: param.autofocus,
                          readOnly: true,
                          showCursor: param.showCursor,
                          textAlign: TextAlign.right,
                          controller: param.controller,
                          style: TextStyle(
                            color: param.textColor,
                            fontSize: fontSize,
                            letterSpacing: letterSpacing,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
