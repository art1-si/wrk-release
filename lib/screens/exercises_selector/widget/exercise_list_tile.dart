import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/create_new_exercise.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/animated_tile.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class ExerciseListTile extends ConsumerWidget {
  static Widget create(BuildContext context,
      {required List<GroupByModel<Exercise>> data}) {
    print("exerciseListTile.create is working");
    return ExerciseListTile(data: data);
  }

  const ExerciseListTile({Key? key, required this.data}) : super(key: key);
  final List<GroupByModel<Exercise>> data;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final exercises = watch(addExerciseLogProvider);

    if (exercises.selectedExercises != null) {
      return Column(
        children: [
          const _Divider(),
          Row(
            children: [
              _BackArowButton(
                onPressed: () =>
                    context.read(addExerciseLogProvider).selectExercises(null),
              ),
              Text(
                exercises.selectedExercises!.first.exerciseType,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: AppTheme.of(context).backgroundDark,
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 20.0),
                itemCount: exercises.selectedExercises!.length,
                itemBuilder: (context, index) {
                  return AnimatedTile(
                    index: index,
                    title: exercises.selectedExercises![index].exerciseName,
                    onTap: () {
                      context
                          .read(addExerciseLogProvider)
                          .setSelectedExerciseIndex(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExerciseToLog(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        const _Divider(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AnimatedTile(
                index: index,
                title: data[index].title,
                onTap: () {
                  context
                      .read(addExerciseLogProvider)
                      .selectExercises(data[index].data);
                },
              );
            },
          ),
        ),
        _CreateNewExerciseButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNewExercise(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BackArowButton extends StatelessWidget {
  const _BackArowButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onPressed,
        child: SizedBox(
          height: 70,
          width: 50,
          child: Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.of(context).divider,
          ),
          height: 5,
          width: 80,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.items,
    required this.subItems,
    required this.showSubItems,
    required this.itemTitle,
  }) : super(key: key);

  final Widget items;
  final Widget subItems;
  final bool showSubItems;
  final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Divider(),
        Row(
          children: [
            _BackArowButton(
              onPressed: () =>
                  context.read(addExerciseLogProvider).selectExercises(null),
            ),
            Text(
              itemTitle,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        showSubItems ? subItems : items,
      ],
    );
  }
}

class _CreateNewExerciseButton extends StatelessWidget {
  const _CreateNewExerciseButton({Key? key, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedHomePageButton(
        width: MediaQuery.of(context).size.width,
        title: "Create New Exercise",
        onPress: onPressed,
        backgroundColor: AppTheme.of(context).accentPositive.withOpacity(0.05),
        titleColor: AppTheme.of(context).accentPositive,
      ),
    );
  }
}
