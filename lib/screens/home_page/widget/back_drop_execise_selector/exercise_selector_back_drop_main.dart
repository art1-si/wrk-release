import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/exercise_tile_widget.dart';

class ExerciseSelectorBackDrop extends StatefulWidget {
  const ExerciseSelectorBackDrop({Key? key, required this.showExerciseSelector})
      : super(key: key);

  final bool showExerciseSelector;

  @override
  State<ExerciseSelectorBackDrop> createState() =>
      _ExerciseSelectorBackDropState();
}

class _ExerciseSelectorBackDropState extends State<ExerciseSelectorBackDrop>
    with SingleTickerProviderStateMixin {
  late final _animationController;

  late Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1.0),
    end: Offset(0, 0.25),
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: isShowingBackDrop ? Curves.easeInCirc : Curves.elasticOut,
  ));

  bool get isShowingBackDrop => widget.showExerciseSelector;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
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
      print("heell");
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0, 1.0),
        end: Offset(0, 0.25),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ));
      _animationController.reverse();
    } else {
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0, 1.0),
        end: Offset(0, 0.25),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ));
      _animationController.forward();
    }
  }

//TODO: stop rebuilding to many times
  @override
  Widget build(BuildContext context) {
    print("backdrop builder");
    _handleAnimation();
    return SlideTransition(
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
    );
  }
}
