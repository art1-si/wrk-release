import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';

class MyGraphWidget extends StatefulWidget {
  final Exercise selectedExercise;

  const MyGraphWidget({
    Key? key,
    required this.selectedExercise,
  }) : super(key: key);
  @override
  _MyGraphWidgetState createState() => _MyGraphWidgetState();
}

class _MyGraphWidgetState extends State<MyGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExerciseLog>>(
        stream: null, //TODO
        builder: (BuildContext context,
            AsyncSnapshot<List<ExerciseLog>> historySnapshot) {
          if (!historySnapshot.hasData) {
            return Center(
              child: Text(
                "Loading Data",
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          } else if (historySnapshot.data!
              .where(
                (element) => (element.exerciseName ==
                    widget.selectedExercise.exerciseName),
              )
              .toList()
              .isEmpty) {
            return Center(
              child: Text(
                "Empty Log",
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
          var filteredHistorySnapshot = historySnapshot.data!
              .where((element) => (element.exerciseName ==
                  widget.selectedExercise.exerciseName))
              .toList();
          return CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: DrawGraph(
              entry: filteredHistorySnapshot,
            ),
          );
        });
  }
}

class DrawGraph extends CustomPainter {
  final List<ExerciseLog> entry;

  const DrawGraph({Key? key, required this.entry});

  @override
  void paint(Canvas canvas, Size size) {
    double len = 10;
    Paint line = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    entry.forEach((element) {
      print(len);
      print(element.weight);
      canvas.drawLine(
          Offset(len, element.weight), Offset(len, size.height / 2), line);
      len += 10;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
