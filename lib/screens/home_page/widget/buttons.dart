import 'dart:async';

import 'package:flutter/material.dart';

class ElevatedHomePageButton extends StatefulWidget {
  const ElevatedHomePageButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.backgroundColor,
    required this.titleColor,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;
  final Color backgroundColor;
  final Color titleColor;

  @override
  State<ElevatedHomePageButton> createState() => _ElevatedHomePageButtonState();
}

class _ElevatedHomePageButtonState extends State<ElevatedHomePageButton> {
  late Color _backgroundColor = widget.backgroundColor;
  late Timer _timer;
  void _onTapDown() {
    print("onTapDown");
    setState(() {
      _backgroundColor = _backgroundColor.withAlpha(25);
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
        onTapCancel: () => _onTapEnd(),
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapEnd(),
        onTap: widget.onPress,
        child: Container(
          height: 42,
          width: 125,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: widget.titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
