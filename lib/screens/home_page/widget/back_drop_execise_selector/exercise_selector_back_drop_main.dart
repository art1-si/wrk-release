import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/exercise_tile_widget.dart';

class ExerciseSelectorBackDrop extends StatefulWidget {
  const ExerciseSelectorBackDrop({
    Key? key,
    required this.showExerciseSelector,
    required this.onTap,
  }) : super(key: key);

  final bool showExerciseSelector;
  final VoidCallback onTap;

  @override
  State<ExerciseSelectorBackDrop> createState() =>
      _ExerciseSelectorBackDropState();
}

class _ExerciseSelectorBackDropState extends State<ExerciseSelectorBackDrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1.0),
    end: _endOffset,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCubic,
  ));

  Offset get _endOffset => Offset(0, 0.22);

  late Animation<double> _fadeAnimation = Tween<double>(
    begin: 0.0,
    end: 0.2,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInCubic,
  ));

  bool get isShowingBackDrop => widget.showExerciseSelector;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _handleAnimation() {
    print("is pressed $isShowingBackDrop");
    if (!isShowingBackDrop) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

//TODO: stop rebuilding to many times
  @override
  Widget build(BuildContext context) {
    print("backdrop builder");
    _handleAnimation();
    return Stack(
      children: [
        if (widget.showExerciseSelector || _animationController.isCompleted)
          GestureDetector(
            onTap: widget.onTap,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
            ),
          ),
        SlideTransition(
          position: _offsetAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ExerciseTileWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
