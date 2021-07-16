import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/exercises_selector/type_selector_page.dart';
import 'package:workout_notes_app/screens/home_page/widget/back_drop_execise_selector/exercise_selector_back_drop_main.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/home_page/widget/log_item_builder.dart';
import 'package:workout_notes_app/constants/strings.dart';
import 'package:workout_notes_app/widgets/day_selector.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showExercise = false;
  void _handleAnimation() {
    setState(() {
      _showExercise = !_showExercise;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePage build");
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (_showExercise) _handleAnimation();
          },
          child: _HomePageBody(
            onExerciseButtonPress: _handleAnimation,
          ),
        ),
        /*     AnimatedOpacity(
          opacity: _showExercise ? 1 : 0.0,
          duration: Duration(milliseconds: 750),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black26,
          ),
        ), */
        ExerciseSelectorBackDrop(
          showExerciseSelector: _showExercise,
        ),
      ],
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
    required this.onExerciseButtonPress,
  }) : super(key: key);
  final VoidCallback onExerciseButtonPress;

  List<Widget> _header(BuildContext context) {
    return <Widget>[
      const Divider(
        height: 20,
        color: Colors.transparent,
      ),
      ElevatedHomePageButton(
        onPress: onExerciseButtonPress,
        title: Strings.exercise,
      ),
      const Divider(
        height: 40,
        color: Colors.transparent,
      ),
      DaySelector(),
      const Divider(
        height: 12,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "Workout Notes",
              style: Theme.of(context).textTheme.headline1,
            ),
            elevation: 0,
            expandedHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                ..._header(context),
                LogItemBuilder(),
                Divider(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
