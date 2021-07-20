import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';

class DaySelector extends ConsumerWidget {
  const DaySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final date = watch(selectedDateProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.read(selectedDateProvider).decrement();
              },
              child: Container(
                height: 24,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onDoubleTap: () => date.resetDate(),
              child: AnimatedDateText(
                title: date.daySelectedToText(),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read(selectedDateProvider).increment();
              },
              child: Container(
                height: 24,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedDateText extends StatefulWidget {
  const AnimatedDateText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AnimatedDateTextState createState() => _AnimatedDateTextState();
}

class _AnimatedDateTextState extends State<AnimatedDateText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedDateText oldWidget) {
    if (widget.title != oldWidget.title) {
      _animationController.reset();
      _animationController.forward();
      print("=====didUpdateWIdget========");
    }

    super.didUpdateWidget(oldWidget);
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
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
