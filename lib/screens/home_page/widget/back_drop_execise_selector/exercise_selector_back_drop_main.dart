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
    begin: const Offset(0, 2),
    end: _endOffset,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.linear,
  ));

  Offset get _endOffset => Offset(0, 0.23 * 1.2);

  late Animation<double> _fadeAnimation = Tween<double>(
    begin: 0.0,
    end: 0.7,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.linear,
  ));

  @override
  void initState() {
    print("====itemCount---${widget.itemCount}======");
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
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
    if (_animationController.value > 0.9) {
      _animationController.forward();
    } else if (_animationController.value < 0.9) {
      _animationController.reverse();
    }
  }

  void handleAnimation() {
    print("handles animation");
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
                      onTap: () {
                        print("shadow tapped");
                        widget.onTap();
                      },
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Color(0xff090A0D),
                        ),
                      ),
                    )
                  : Container();
            }),
        SlideTransition(
          position: _offsetAnimation,
          child: LayoutBuilder(builder: (_, constraints) {
            return GestureDetector(
              onTap: () => print("backdrop tapped"),
              onVerticalDragStart: (details) => _handleDragDownStart(details),
              onVerticalDragUpdate: (details) =>
                  _handleDragDownUpdate(details, constraints.maxHeight * 1.2),
              onVerticalDragEnd: (details) => _handleDragDownEnd(details),
              child: Container(
                height: constraints.maxHeight * 0.8,
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
            );
          }),
        ),
      ],
    );
  }
}
