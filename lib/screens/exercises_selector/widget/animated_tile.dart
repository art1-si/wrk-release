import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  const AnimatedTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final int index;

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
    final _screenWidth = MediaQuery.of(context).size.width;
    return FadeTransition(
      opacity: _offsetAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            ListTile(
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
