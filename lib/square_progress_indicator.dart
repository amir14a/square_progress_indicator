library square_percent_indicater;

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SquareProgressIndicator extends StatelessWidget {
  final double width;
  final double height;
  final double value;

  ///square border radius
  final double borderRadius;
  final Color progressColor;
  final Color shadowColor;

  ///thickness of the progress
  final double strokeWidth;
  final double shadowWidth;
  final Widget? child;

  ///if true the progress is moving clockwise
  final bool reverse;

  final double startFrom;

  const SquareProgressIndicator({
    super.key,
    this.value = 0.0,
    this.reverse = false,
    this.borderRadius = 8,
    this.progressColor = Colors.blue,
    this.shadowColor = Colors.grey,
    this.strokeWidth = 5,
    this.shadowWidth = 5,
    this.child,
    this.startFrom = 0,
    this.width = 150,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: RadialPainter(
        startFrom: startFrom,
        progress: value,
        color: progressColor,
        shadowColor: shadowColor,
        reverse: reverse,
        strokeWidth: strokeWidth,
        shadowWidth: shadowWidth,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class RadialPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color shadowColor;
  final double strokeWidth;
  final double shadowWidth;
  final double borderRadius;
  final bool reverse;
  final double startFrom;

  RadialPainter({
    required this.progress,
    this.color = Colors.blue,
    this.shadowColor = Colors.grey,
    this.strokeWidth = 4,
    this.shadowWidth = 1,
    this.reverse = false,
    this.startFrom = 0,
    this.borderRadius = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = borderRadius > 0 ? StrokeCap.round : StrokeCap.square
      ..strokeJoin = StrokeJoin.miter;

    Paint shadowPaint = Paint()
      ..color = shadowColor
      ..strokeWidth = shadowWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = borderRadius > 0 ? StrokeCap.round : StrokeCap.square
      ..strokeJoin = StrokeJoin.miter;

    var path = Path();
    Path dashPath = Path();

    var topLeft = Offset(borderRadius + strokeWidth / 2, borderRadius + strokeWidth / 2);
    var topRight = Offset(size.width - borderRadius - strokeWidth / 2, borderRadius + strokeWidth / 2);
    var bottomRight =
        Offset(size.width - borderRadius - strokeWidth / 2, size.height - borderRadius - strokeWidth / 2);
    var bottomLeft = Offset(borderRadius + strokeWidth / 2, size.height - borderRadius - strokeWidth / 2);

    path.arcTo(Rect.fromCircle(center: topLeft, radius: borderRadius), -3 * pi / 4, pi / 4, false);
    path.lineTo(size.width - borderRadius - strokeWidth / 2, strokeWidth / 2);
    path.arcTo(Rect.fromCircle(center: topRight, radius: borderRadius), -pi / 2, pi / 2, false);
    path.lineTo(size.width - strokeWidth / 2, size.height - borderRadius - strokeWidth / 2);
    path.arcTo(Rect.fromCircle(center: bottomRight, radius: borderRadius), 0, pi / 2, false);
    path.lineTo(0 + borderRadius + strokeWidth / 2, size.height - strokeWidth / 2);
    path.arcTo(Rect.fromCircle(center: bottomLeft, radius: borderRadius), pi / 2, pi / 2, false);
    path.lineTo(0 + strokeWidth / 2, borderRadius + strokeWidth / 2);
    path.arcTo(Rect.fromCircle(center: topLeft, radius: borderRadius), pi, pi / 4, false);

    for (PathMetric pathMetric in path.computeMetrics()) {
      dashPath.addPath(
          pathMetric.extractPath(
            pathMetric.length * startFrom,
            pathMetric.length * progress + pathMetric.length * startFrom,
          ),
          Offset.zero);
      dashPath.addPath(
          pathMetric.extractPath(
            0,
            pathMetric.length * (progress - (1 - startFrom)),
          ),
          Offset.zero);
    }

    if (reverse) {
      // dashPath = dashPath
      //     .transform(Matrix4Transform().rotate(pi / 2).m.storage)
      //     .transform(Matrix4Transform().flipHorizontally().m.storage);
    }

    // dashPath = dashPath.transform(Matrix4Transform().rotateByCenter(startAngle.value, size).m.storage);

    canvas.drawPath(path, shadowPaint);
    if (progress > 0) canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class StartFrom {
  static const topLeft = 0;
  static const topCenter = .125;
  static const topRight = .125 * 2;
  static const rightCenter = .125 * 3;
  static const bottomRight = .125 * 4;
  static const bottomLeft = .125 * 5;
  static const leftCenter = .125 * 7;
}
