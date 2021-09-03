import 'package:flutter/material.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class ExerciseSelectorBackDrop extends StatefulWidget {
  const ExerciseSelectorBackDrop({
    Key? key,
    required this.onTap,
    required this.itemCount,
    required this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final int itemCount;
  final Widget child;

  @override
  State<ExerciseSelectorBackDrop> createState() =>
      ExerciseSelectorBackDropState();
}

class ExerciseSelectorBackDropState extends State<ExerciseSelectorBackDrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1 / 0.75),
    end: _endOffset,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCubic,
  ));

  Offset get _endOffset => Offset(0, 0.22 / 0.75);

  late Animation<double> _fadeAnimation = Tween<double>(
    begin: 0.0,
    end: 0.5,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInCubic,
  ));

  @override
  void initState() {
    print("====itemCount---${widget.itemCount}======");
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _handleDragDownStart(DragStartDetails details) {
    //TODO:
  }

  void _handleDragDownUpdate(DragUpdateDetails details, double crossAxle) {
    print("hande drag up");
    _animationController.value -= details.primaryDelta! / crossAxle;
  }

  void _handleDragDownEnd(DragEndDetails details) {
    print("end");
    if (_animationController.value < 0.2) {
      _animationController..forward();
    } else if (_animationController.value < 1) {
      _animationController.reverse();
    }
  }

  void handleAnimation() {
    if (_animationController.value == 1.0) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

//TODO: stop rebuilding to many times
  @override
  Widget build(BuildContext context) {
    print("backdrop builder");
    print(_animationController.value);
    return Stack(
      children: [
        AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return (_fadeAnimation.value > 0.01)
                  ? GestureDetector(
                      onTap: widget.onTap,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container();
            }),
        LayoutBuilder(
          builder: (_, constraints) {
            return GestureDetector(
              onVerticalDragStart: (details) => _handleDragDownStart(details),
              onVerticalDragUpdate: (details) =>
                  _handleDragDownUpdate(details, constraints.maxHeight),
              onVerticalDragEnd: (details) => _handleDragDownEnd(details),
              child: SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  height: constraints.maxHeight * 0.78,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: widget.child,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
