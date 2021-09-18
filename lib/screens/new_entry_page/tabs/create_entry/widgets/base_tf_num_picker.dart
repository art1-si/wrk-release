import 'package:flutter/material.dart';

class BaseTFNumPicker extends StatelessWidget {
  const BaseTFNumPicker({
    Key? key,
    required this.title,
    required this.child,
    required this.onPressedLeftArow,
    required this.onPressedRightArow,
    required this.leftSubText,
    required this.rightSubText,
    required this.reachedZero,
    required this.width,
  }) : super(key: key);

  final String title;
  final Widget child;
  final VoidCallback onPressedLeftArow;
  final VoidCallback onPressedRightArow;
  final String leftSubText;
  final String rightSubText;
  final bool reachedZero;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onPressedLeftArow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: reachedZero ? Colors.white : Colors.white30,
                        size: 40,
                      ),
                    ),
                    Text(
                      leftSubText,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white38,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width,
                child: child,
              ),
              GestureDetector(
                onTap: onPressedRightArow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rightSubText,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white38,
                        letterSpacing: 2.5,
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
