import 'package:flutter/material.dart';

class ElevatedHomePageButton extends StatelessWidget {
  const ElevatedHomePageButton(
      {Key? key, required this.title, required this.onPress})
      : super(key: key);

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          height: 42,
          width: 125,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }
}
