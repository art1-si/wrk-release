import 'package:flutter/material.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class ElevatedHomePageButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          height: 42,
          width: 125,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
