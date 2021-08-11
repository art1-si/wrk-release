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
  late final _offsetShadowAnimation;
  late var _duration = widget.index == 0
      ? 0
      : (widget.index.isEven
          ? (widget.index + 8) * 20
          : (widget.index + 8) * 40);
  late var _timer = Timer(Duration(milliseconds: _duration), () async {
    await _animationController.forward();
  });

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic));

    _offsetShadowAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
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
    return Stack(
      children: [
        SlideTransition(
          position: _offsetShadowAnimation,
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
        SlideTransition(
          position: _offsetAnimation,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
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
        ),
      ],
    );
  }
}
