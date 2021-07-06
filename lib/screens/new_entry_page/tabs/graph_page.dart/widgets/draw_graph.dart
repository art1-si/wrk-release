import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

class DrawGraph extends CustomPainter {
  final double minValue;
  final double maxValue;
  final GraphModelProvider graphProvider;

  final Color lineColor;

  final double sizeWidth;

  const DrawGraph({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.sizeWidth,
    required this.graphProvider,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final entry = graphProvider.findOffsets(size: size);
    Color gradinetColorStarter = (graphProvider.pressedPosition == null)
        ? lineColor.withOpacity(0.1)
        : Colors.orange[300]!.withOpacity(0.1);
    Color endGradinetColor = (graphProvider.pressedPosition == null)
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
      ..color = (graphProvider.pressedPosition == null)
          ? lineColor
          : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Paint points = Paint()
      ..color = (graphProvider.pressedPosition == null)
          ? lineColor
          : Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    entry.forEach((element) {
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
    if (graphProvider.tappedLog != null) {
      canvas.drawLine(
          Offset(graphProvider.tappedLog!.x, graphProvider.tappedLog!.y),
          Offset(graphProvider.tappedLog!.x, graphProvider.tappedLog!.y),
          points);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
