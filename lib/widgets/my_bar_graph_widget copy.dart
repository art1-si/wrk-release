import 'package:flutter/material.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/provider/exercise_log_stream.dart';

class MyGraphWidget extends StatefulWidget {
  final ExerciseModel selectedExercise;

  const MyGraphWidget({Key key, this.selectedExercise}) : super(key: key);
  @override
  _MyGraphWidgetState createState() => _MyGraphWidgetState();
}

class _MyGraphWidgetState extends State<MyGraphWidget> {
  ExerciseLogStreams exerciseLogStream = ExerciseLogStreams();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExerciseLogModel>>(
        stream: exerciseLogStream.exereciseLogStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<ExerciseLogModel>> historySnapshot) {
          if (!historySnapshot.hasData) {
            return Center(
              child: Text(
                "Loading Data",
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          } else if (historySnapshot.data
              .where((element) => (element.exerciseName ==
                  widget.selectedExercise.exerciseName))
              .toList()
              .isEmpty) {
            return Center(
              child: Text(
                "Empty Log",
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }
          var filteredHistorySnapshot = historySnapshot.data
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
  final List<ExerciseLogModel> entry;

  const DrawGraph({Key key, this.entry});

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
