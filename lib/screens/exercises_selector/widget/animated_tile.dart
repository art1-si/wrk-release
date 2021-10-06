import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workout_notes_app/constants/lists.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class AnimatedTile extends StatefulWidget {
  const AnimatedTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.index,
    this.showTrailing = false,
    this.onTrailingValueChanged,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final int index;
  final bool showTrailing;
  final ValueChanged<String>? onTrailingValueChanged;

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final _offsetAnimation;

  late var _duration = 20;

  late var _timer = Timer(Duration(milliseconds: _duration), () async {
    await _animationController.forward();
  });

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _offsetAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic));

    // ignore: unnecessary_statements
    _timer;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _offsetAnimation,
      child: Container(
        child: Column(
          children: [
            ListTile(
              trailing: widget.showTrailing
                  ? _ThreeDotIcon(onChanged: widget.onTrailingValueChanged!)
                  : null,
              title: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                if (_animationController.isCompleted) widget.onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreeDotIcon extends StatefulWidget {
  const _ThreeDotIcon({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  State<_ThreeDotIcon> createState() => _ThreeDotIconState();
}

class _ThreeDotIconState extends State<_ThreeDotIcon> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      //value: dropdownValue,
      icon: const Icon(Icons.more_vert),
      dropdownColor: AppTheme.of(context).primary,
      iconSize: 24,
      elevation: 0,
      style: const TextStyle(color: Colors.white60),
      underline: SizedBox(),
      onChanged: (value) => widget.onChanged(value!),
      items: <String>[...ConstLists.dropdownValuesForExerciseListTile]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
