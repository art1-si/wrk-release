import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/exercise_tile_widget.dart';
import 'package:workout_notes_app/screens/home_page/widget/back_drop_execise_selector/exercise_selector_back_drop_main.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/home_page/widget/log_item_builder.dart';
import 'package:workout_notes_app/constants/strings.dart';
import 'package:workout_notes_app/theme/app_theme.dart';
import 'package:workout_notes_app/widgets/day_selector.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _dropDownAnimationKey = GlobalKey<ExerciseSelectorBackDropState>();

  @override
  Widget build(BuildContext context) {
    print("MyHomePage build");
    return Stack(
      children: [
        _HomePageBody(
          onExerciseButtonPress: () {
            _dropDownAnimationKey.currentState?.handleAnimation();
          },
        ),
        ExerciseTileWidget(
          keyToPass: _dropDownAnimationKey,
          onTap: () {
            _dropDownAnimationKey.currentState?.handleAnimation();
          },
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
        backgroundColor: AppTheme.of(context).accentPrimary.withOpacity(0.1),
        titleColor: AppTheme.of(context).accentPrimary,
      ),
      const Divider(
        height: 20,
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
    return Container(
      color: AppTheme.of(context).background,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme.of(context).background,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                title: Text(
                  "Workout Notes",
                  style: Theme.of(context).textTheme.headline1,
                ),
                elevation: 0,
                expandedHeight: 90,
                backgroundColor: AppTheme.of(context).background,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    ..._header(context),
                    LogItemBuilder(),
                    Divider(
                      height: 40,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
