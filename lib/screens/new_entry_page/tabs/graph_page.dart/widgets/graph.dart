import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

class MyDrawGraph extends StatefulWidget {
  final List<ExerciseLog> snapshotToPass;

  const MyDrawGraph({Key? key, required this.snapshotToPass}) : super(key: key);
  @override
  _MyDrawGraphState createState() => _MyDrawGraphState();
}

class _MyDrawGraphState extends State<MyDrawGraph> {
  Offset? _tapPosition;
  bool isPressed = false;
  var referenceBox;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width - 50;
    List listOfXOffset = <double>[];
    var index = 0;
    if (_tapPosition != null) {
      if (widget.snapshotToPass.isNotEmpty &&
          widget.snapshotToPass.length > 1) {
        var len = 50.0;
        var len2 = (sizeWidth - 50) / (widget.snapshotToPass.length - 1);
        widget.snapshotToPass.forEach((element) {
          listOfXOffset.add(len);
          len = len + len2;
        });
        var distance = listOfXOffset[1] - listOfXOffset.first;
        for (var i = 0; i < listOfXOffset.length; i++) {
          if (listOfXOffset[i] < _tapPosition!.dx + distance / 2 &&
              listOfXOffset[i] + distance > _tapPosition!.dx + distance / 2) {
            index = i;
          }
        }
      }
    }
    return GestureDetector(
      onPanDown: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanStart: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanUpdate: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanEnd: (details) {
        setState(() {
          _tapPosition = null;
        });
      },
      onPanCancel: () {
        setState(() {
          _tapPosition = null;
        });
      },
      child: Consumer(
        builder: (context, watch, child) {
          final _graphProvider =
              watch(graphProvider(widget.snapshotToPass)); //TODO make it better
          return CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: DrawGraph(
              sizeWidth: MediaQuery.of(context).size.width - 50,
              lineColor: Theme.of(context).accentColor,
              entry: widget.snapshotToPass,
              linePosition: _tapPosition,
              maxValue: _graphProvider.maxValue,
              minValue: _graphProvider.minValue,
            ),
          );
        },
      ),
    );
  }
}

class DrawGraph extends CustomPainter {
  final double minValue;
  final double maxValue;
  final Offset? linePosition;
  final List<ExerciseLog> entry;
  final Color lineColor;

  final TextStyle? paragraphStyle;
  final double sizeWidth;

  const DrawGraph({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.linePosition,
    required this.sizeWidth,
    required this.entry,
    required this.lineColor,
    this.paragraphStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    int index = 0;

    double distance = 50;
    double nextDistance = (size.width - 50) / (entry.length - 1);
    double lastWeighValue = entry.first.weight;
    List listOfXOffset = <double>[];
    List listOfYOffset = <double>[];

    Color gradinetColorStarter = (linePosition == null)
        ? lineColor.withOpacity(0.1)
        : Colors.orange[300]!.withOpacity(0.1);
    Color endGradinetColor = (linePosition == null)
        ? Colors.blue.withOpacity(0.005)
        : Colors.blue.withOpacity(0.005);
    final gradient = LinearGradient(
      colors: [gradinetColorStarter, endGradinetColor],
      stops: [0.4, 0.99],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    Paint shadowLine2 = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Paint line2 = Paint()
      ..color = (linePosition == null) ? lineColor : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Paint points = Paint()
      ..color = (linePosition == null) ? lineColor : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    index = 0;

    distance = 50;
    nextDistance = (sizeWidth - 50) / (entry.length - 1);
    lastWeighValue = entry.first.weight;

    if (entry.isNotEmpty) {
      entry.forEach((element) {
        print(element.dateCreated);
        double weightGraphValue = element.weight;
        double relativeYposition =
            (weightGraphValue - minValue) / (maxValue - minValue);
        double yOffset = size.height - relativeYposition * size.height;

        double lastRelativeYposition =
            (lastWeighValue - minValue) / (maxValue - minValue);
        double yLastOffset = size.height - lastRelativeYposition * size.height;

        listOfXOffset.add(distance);
        listOfYOffset.add(yOffset);

        //Draw main line
        canvas.drawLine(
            Offset(distance, yOffset),
            Offset(((distance == 50) ? distance : distance - nextDistance),
                yLastOffset),
            line2);

        //Draw background
        canvas.drawPath(
          Path()
            ..moveTo((distance == 50) ? distance : distance - nextDistance,
                size.height - 5)
            ..lineTo(distance, size.height - 5)
            ..lineTo(distance, yOffset)
            ..lineTo((distance == 50) ? distance : distance - nextDistance,
                yLastOffset),
          shadowLine2,
        );

        distance = distance + nextDistance;
        lastWeighValue = element.weight;
        index++;
      });
    } else {
      listOfXOffset = [];
      distance = 50;
      nextDistance = (sizeWidth - 50) / (entry.length - 1);
      entry.forEach((element) {
        listOfXOffset.add(distance);
        canvas.drawLine(
            Offset(distance, size.height / 2),
            Offset(((distance == 50) ? distance : distance - nextDistance),
                size.height / 2),
            line2);
        canvas.drawPath(
          Path()
            ..moveTo((distance == 50) ? distance : distance - nextDistance,
                size.height - 5)
            ..lineTo(distance, size.height - 5)
            ..lineTo(distance, size.height / 2)
            ..lineTo((distance == 50) ? distance : distance - nextDistance,
                size.height / 2),
          shadowLine2,
        );
        distance = distance + nextDistance;
      });
    }

    if (linePosition != null && listOfXOffset.isNotEmpty) {
      var distance = listOfXOffset[1] - listOfXOffset.first;

      for (var i = 0; i < listOfXOffset.length; i++) {
        if (listOfXOffset[i] < linePosition!.dx + distance / 2 &&
            listOfXOffset[i] + distance > linePosition!.dx + distance / 2) {
          canvas.drawLine(
              Offset(listOfXOffset[i],
                  (listOfYOffset.isEmpty) ? size.height / 2 : listOfYOffset[i]),
              Offset(listOfXOffset[i],
                  (listOfYOffset.isEmpty) ? size.height / 2 : listOfYOffset[i]),
              points);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
