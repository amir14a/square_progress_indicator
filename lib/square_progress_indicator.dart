library;

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SquareProgressIndicator extends StatelessWidget {
  ///The width of rectangle that the progress line is drawn around it.
  final double width;

  ///The height of rectangle that the progress line is drawn around it.
  final double height;

  ///The value of the progress, it should be between 0 and 1.
  final double? value;

  ///The border radius of the rectangle, it is applied to all four corners.
  final double borderRadius;

  ///The color of the progress line.
  final Color? color;

  ///The color of the line behind the progress line which show for reminding progress.
  final Color? emptyStrokeColor;

  ///The width of the progress line.
  final double strokeWidth;

  ///The width of the line behind the progress line which show for reminding progress.
  final double emptyStrokeWidth;

  ///The child widget, it can be a text or everything you need.
  final Widget? child;

  ///The direction of turn of progress line, if you pass false, the progress line will be reversed, default value is true.
  final bool clockwise;

  ///Start position of progress line relative to the topCenter, you can pass a value from [StartPosition] class or custom double value you need.
  final double startPosition;

  ///The stroke align of the progress line, pass a value from [SquareStrokeAlign] and read it's documents. see: https://api.flutter.dev/flutter/painting/BorderSide/strokeAlign.html
  final SquareStrokeAlign strokeAlign;

  ///The stroke cap of the progress line and empty line, see: https://api.flutter.dev/flutter/dart-ui/StrokeCap.html
  final StrokeCap? strokeCap;

  const SquareProgressIndicator({
    super.key,
    this.value,
    this.clockwise = true,
    this.borderRadius = 8,
    this.color,
    this.emptyStrokeColor,
    this.strokeWidth = 4,
    this.emptyStrokeWidth = 4,
    this.child,
    this.startPosition = 0,
    this.width = 38,
    this.height = 38,
    this.strokeAlign = SquareStrokeAlign.inside,
    this.strokeCap,
  }) : assert(startPosition >= 0 && startPosition <= 1,
            "'startFrom' must be between 0 and 1");

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return _IndeterminateSquareProgressIndicator(
        clockwise: clockwise,
        borderRadius: borderRadius,
        color: color ??
            Theme.of(context).progressIndicatorTheme.color ??
            Colors.blue,
        emptyStrokeColor: emptyStrokeColor ??
            Theme.of(context).progressIndicatorTheme.circularTrackColor ??
            Colors.transparent,
        strokeWidth: strokeWidth,
        emptyStrokeWidth: emptyStrokeWidth,
        startPosition: startPosition,
        width: width,
        height: height,
        strokeAlign: strokeAlign,
        strokeCap: strokeCap,
        child: child,
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _SquareProgressIndicatorStrokePainter(
          startPosition: startPosition,
          value: value!,
          color: color ??
              Theme.of(context).progressIndicatorTheme.color ??
              Colors.blue,
          emptyStrokeColor: emptyStrokeColor ??
              Theme.of(context).progressIndicatorTheme.circularTrackColor ??
              Colors.transparent,
          clockwise: clockwise,
          strokeWidth: strokeWidth,
          emptyStrokeWidth: emptyStrokeWidth,
          borderRadius: borderRadius,
          strokeAlign: strokeAlign,
          strokeCap: strokeCap,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _SquareProgressIndicatorStrokePainter extends CustomPainter {
  final double value;
  final Color color;
  final Color emptyStrokeColor;
  final double strokeWidth;
  final double emptyStrokeWidth;
  final double borderRadius;
  final bool clockwise;
  final double startPosition;
  final SquareStrokeAlign strokeAlign;
  final StrokeCap? strokeCap;

  _SquareProgressIndicatorStrokePainter({
    required this.value,
    this.color = Colors.blue,
    this.emptyStrokeColor = Colors.grey,
    this.strokeWidth = 4,
    this.emptyStrokeWidth = 1,
    this.clockwise = false,
    this.startPosition = 0,
    this.borderRadius = 10,
    this.strokeAlign = SquareStrokeAlign.inside,
    this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint strokePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap =
          strokeCap ?? (borderRadius > 0 ? StrokeCap.round : StrokeCap.square)
      ..strokeJoin = StrokeJoin.miter;

    Paint emptyStrokePaint = Paint()
      ..color = emptyStrokeWidth <= 0 ? Colors.transparent : emptyStrokeColor
      ..strokeWidth = emptyStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap =
          strokeCap ?? (borderRadius > 0 ? StrokeCap.round : StrokeCap.square)
      ..strokeJoin = StrokeJoin.miter;

    var emptyStrokePath = Path();
    var strokePath = Path();

    var strokeOffset = strokeAlign == SquareStrokeAlign.inside
        ? strokeWidth / 2
        : strokeAlign == SquareStrokeAlign.outside
            ? -strokeWidth / 2
            : 0.0;

    var topLeft =
        Offset(borderRadius + strokeOffset, borderRadius + strokeOffset);
    var topRight = Offset(
        size.width - borderRadius - strokeOffset, borderRadius + strokeOffset);
    var bottomRight = Offset(size.width - borderRadius - strokeOffset,
        size.height - borderRadius - strokeOffset);
    var bottomLeft = Offset(
        borderRadius + strokeOffset, size.height - borderRadius - strokeOffset);

    if (clockwise) {
      emptyStrokePath.moveTo(size.width / 2 + strokeWidth / 2, strokeOffset);
      emptyStrokePath.lineTo(
          size.width - borderRadius - strokeOffset, strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: topRight, radius: borderRadius),
          -pi / 2,
          pi / 2,
          false);
      emptyStrokePath.lineTo(
          size.width - strokeOffset, size.height - borderRadius - strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: bottomRight, radius: borderRadius),
          0,
          pi / 2,
          false);
      emptyStrokePath.lineTo(
          0 + borderRadius + strokeOffset, size.height - strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: bottomLeft, radius: borderRadius),
          pi / 2,
          pi / 2,
          false);
      emptyStrokePath.lineTo(0 + strokeOffset, borderRadius + strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: topLeft, radius: borderRadius),
          pi,
          pi / 2,
          false);
      emptyStrokePath.lineTo(size.width / 2 + strokeWidth / 2, strokeOffset);
    } else {
      emptyStrokePath.moveTo(size.width / 2 - strokeWidth / 2, strokeOffset);
      emptyStrokePath.lineTo(0 + strokeOffset + borderRadius, strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: topLeft, radius: borderRadius),
          -pi / 2,
          -pi / 2,
          false);
      emptyStrokePath.lineTo(
          0 + strokeOffset, size.height - borderRadius - strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: bottomLeft, radius: borderRadius),
          -pi,
          -pi / 2,
          false);
      emptyStrokePath.lineTo(
          size.width - borderRadius - strokeOffset, size.height - strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: bottomRight, radius: borderRadius),
          pi / 2,
          -pi / 2,
          false);
      emptyStrokePath.lineTo(
          size.width - strokeOffset, borderRadius + strokeOffset);
      emptyStrokePath.arcTo(
          Rect.fromCircle(center: topRight, radius: borderRadius),
          0,
          -pi / 2,
          false);
      emptyStrokePath.lineTo(size.width / 2 - strokeWidth / 2, strokeOffset);
    }

    for (PathMetric pathMetric in emptyStrokePath.computeMetrics()) {
      var startPos = clockwise ? startPosition : (1 - startPosition);
      strokePath.addPath(
          pathMetric.extractPath(
            pathMetric.length * startPos,
            pathMetric.length * value + pathMetric.length * startPos,
          ),
          Offset.zero);
      strokePath.addPath(
          pathMetric.extractPath(
            0,
            pathMetric.length * (value - (1 - startPos)),
          ),
          Offset.zero);
    }

    canvas.drawPath(emptyStrokePath, emptyStrokePaint);
    if (value > 0) canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class StartPosition {
  static const topCenter = 0.0;

  ///This works only when width=height
  static const topRight = .125 * 1;
  static const rightCenter = .125 * 2;

  ///This works only when width=height
  static const bottomRight = .125 * 3;
  static const bottomCenter = .125 * 4;

  ///This works only when width=height
  static const bottomLeft = .125 * 5;
  static const leftCenter = .125 * 6;

  ///This works only when width=height
  static const topLeft = .125 * 7;
}

enum SquareStrokeAlign {
  ///When you use [center], half of stroke width is drawn inside the rectangle bounds and other half is drawn outside the bounds.
  center,

  ///When you use [outside], stroke line is drawn outside the rectangle bounds, maybe draw on other widgets.
  outside,

  ///When you use [inside], stroke line is drawn inside the rectangle bounds, this is default value.
  inside
}

class _IndeterminateSquareProgressIndicator extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  final Color emptyStrokeColor;
  final double strokeWidth;
  final double emptyStrokeWidth;
  final Widget? child;
  final bool clockwise;
  final double startPosition;
  final SquareStrokeAlign strokeAlign;
  final StrokeCap? strokeCap;

  const _IndeterminateSquareProgressIndicator({
    required this.clockwise,
    required this.borderRadius,
    required this.color,
    required this.emptyStrokeColor,
    required this.strokeWidth,
    required this.emptyStrokeWidth,
    required this.startPosition,
    required this.width,
    required this.height,
    required this.strokeAlign,
    this.strokeCap,
    this.child,
  });

  @override
  State<_IndeterminateSquareProgressIndicator> createState() =>
      _IndeterminateSquareProgressIndicatorState();
}

class _IndeterminateSquareProgressIndicatorState
    extends State<_IndeterminateSquareProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350 * 8));
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300 * 3));
    _controller.repeat();
    _controller2.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, w) {
        return AnimatedBuilder(
            animation: _controller2,
            builder: (context, w) {
              var anim2var = _controller2
                      .drive(CurveTween(curve: Curves.easeInOutQuart))
                      .value *
                  1;
              return SquareProgressIndicator(
                value: anim2var * .7,
                clockwise: widget.clockwise,
                borderRadius: widget.borderRadius,
                color: widget.color,
                emptyStrokeColor: widget.emptyStrokeColor,
                strokeWidth: widget.strokeWidth,
                emptyStrokeWidth: widget.emptyStrokeWidth,
                startPosition: (widget.startPosition +
                        (widget.clockwise
                            ? ((_controller2.status == AnimationStatus.reverse
                                ? (_controller.value + 1 - (anim2var))
                                : _controller.value))
                            : ((_controller2.status == AnimationStatus.reverse
                                ? ((1 - _controller.value) - 1 + (anim2var))
                                : (1 - _controller.value))))) %
                    1,
                width: widget.width,
                height: widget.height,
                strokeAlign: widget.strokeAlign,
                strokeCap: widget.strokeCap,
                child: widget.child,
              );
            });
      },
      animation: _controller,
    );
  }
}
