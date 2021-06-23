import 'package:flutter/material.dart';

class WorkoutListTile extends StatelessWidget {
  final Widget title;
  final Widget? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  const WorkoutListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.leading,
    this.trailing,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 16.0),
              child: Row(
                children: [
                  title,
                  //trailing,
                ],
              ),
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
