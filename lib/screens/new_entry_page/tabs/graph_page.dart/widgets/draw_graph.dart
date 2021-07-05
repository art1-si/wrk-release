import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

class DrawGraph extends CustomPainter {
  final double minValue;
  final double maxValue;
  final Offset? linePosition;
  final GraphModelProvider graphProvider;

  final Color lineColor;

  final TextStyle? paragraphStyle;
  final double sizeWidth;

  const DrawGraph({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.linePosition,
    required this.sizeWidth,
    required this.graphProvider,
    required this.lineColor,
    this.paragraphStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final entry = graphProvider.findOffsets(size: size);
    print("graph size $size");
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

    entry.forEach((element) {
      print("x :${element.x}");

      print("y :${element.y}");
      print("next x :${element.nextX}");

      print("next y :${element.nextY}");
      //Draw main line
      canvas.drawLine(Offset(element.x, element.y),
          Offset(element.nextX, element.nextY), line2);

      //Draw background
      canvas.drawPath(
        Path()
          ..moveTo(element.x, element.y)
          ..lineTo(element.x, size.height)
          ..lineTo(element.nextX, size.height)
          ..lineTo(element.nextX, element.nextY),
        shadowLine2,
      );
    });

    /* if (linePosition != null && listOfXOffset.isNotEmpty) {
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
    } */
  }

  void _drawLine(GraphModel points) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
