import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  const AnimatedTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.index,
    this.showTrailing = false,
    this.onTrailingPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final int index;
  final bool showTrailing;
  final VoidCallback? onTrailingPressed;

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
                  ? _ThreeDotIcon(onPressed: widget.onTrailingPressed!)
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

class _ThreeDotIcon extends StatelessWidget {
  const _ThreeDotIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 20,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
