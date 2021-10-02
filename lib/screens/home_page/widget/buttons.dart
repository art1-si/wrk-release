import 'dart:async';

import 'package:flutter/material.dart';

class ElevatedHomePageButton extends StatefulWidget {
  const ElevatedHomePageButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.backgroundColor,
    required this.titleColor,
    this.width = 150,
    this.disable = false,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;
  final Color backgroundColor;
  final Color titleColor;
  final bool disable;
  final double width;

  @override
  State<ElevatedHomePageButton> createState() => _ElevatedHomePageButtonState();
}

class _ElevatedHomePageButtonState extends State<ElevatedHomePageButton> {
  late Color _backgroundColor = widget.backgroundColor;
  late Timer _timer;
  void _onTapDown() {
    print("onTapDown");
    setState(() {
      _backgroundColor = _backgroundColor.withAlpha(50);
    });
  }

  void _onTapEnd() {
    print("onTapEnd");
    setState(() {
      _backgroundColor = widget.backgroundColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapCancel: () {
          if (!widget.disable) {
            _onTapEnd();
          }
        },
        onTapDown: (_) {
          if (!widget.disable) {
            _onTapDown();
          }
        },
        onTapUp: (_) {
          if (!widget.disable) {
            _onTapEnd();
          }
        },
        onTap: () {
          if (!widget.disable) {
            widget.onPress();
          }
        },
        child: Container(
          height: 42,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.disable
                ? Colors.grey.withOpacity(0.02)
                : _backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.button!.copyWith(
                  color: widget.disable
                      ? Colors.grey.withOpacity(0.2)
                      : widget.titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
