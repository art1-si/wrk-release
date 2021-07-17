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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack));

    var _duration = widget.index == 0 ? 0 : widget.index * 20;

    Future.delayed(Duration(milliseconds: _duration), () async {
      await _animationController.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: ListTile(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        onTap: () {
          if (_animationController.isCompleted) widget.onTap();
        },
      ),
    );
  }
}
