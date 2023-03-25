import 'package:flutter/material.dart';

class PatternLock extends StatefulWidget {
  final int dimension;
  final List<int>? initialPoints;
  final double relativePadding;
  final Color? selectedColor;
  final Color notSelectedColor;
  final double pointRadius;
  final bool showInput;
  final int selectThreshold;
  final bool fillPoints;
  final bool onlyView;
  final Function(List<int>) onInputComplete;

  const PatternLock({
    Key? key,
    this.dimension = 3,
    this.initialPoints,
    this.relativePadding = 0.7,
    this.selectedColor,
    this.notSelectedColor = Colors.black45,
    this.pointRadius = 10,
    this.showInput = true,
    this.selectThreshold = 25,
    this.fillPoints = false,
    this.onlyView = false,
    required this.onInputComplete,
  }) : super(key: key);

  @override
  // _PatternLockState createState() => _PatternLockState();
  State<PatternLock> createState() => _PatternLockState();
}

class _PatternLockState extends State<PatternLock> {
  List<int> used = [];
  Offset? currentPoint;

  @override
  void initState() {
    super.initState();
    if (widget.initialPoints != null) used = widget.initialPoints!;
  }

  @override
  void didUpdateWidget(covariant PatternLock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPoints != null) used = widget.initialPoints!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (DragEndDetails details) {
        if (used.isNotEmpty) {
          widget.onInputComplete(used);
        }
        setState(() {
          currentPoint = null;
        });
      },
      onPanUpdate: (DragUpdateDetails details) {
        if (widget.onlyView) return;
        RenderBox referenceBox = context.findRenderObject() as RenderBox;
        Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

        Offset circlePosition(int n) => calcCirclePosition(
              n,
              referenceBox.size,
              widget.dimension,
              widget.relativePadding,
            );

        setState(() {
          currentPoint = localPosition;
          for (int i = 0; i < widget.dimension * widget.dimension; ++i) {
            final toPoint = (circlePosition(i) - localPosition).distance;
            if (!used.contains(i) && toPoint < widget.selectThreshold) {
              used.add(i);
            }
          }
        });
      },
      child: CustomPaint(
        painter: _LockPainter(
          dimension: widget.dimension,
          used: used,
          currentPoint: currentPoint,
          relativePadding: widget.relativePadding,
          selectedColor: widget.selectedColor ?? Theme.of(context).primaryColor,
          notSelectedColor: widget.notSelectedColor,
          pointRadius: widget.pointRadius,
          showInput: widget.showInput,
          fillPoints: widget.fillPoints,
        ),
        size: Size.infinite,
      ),
    );
  }
}

@immutable
class _LockPainter extends CustomPainter {
  final int dimension;
  final List<int> used;
  final Offset? currentPoint;
  final double relativePadding;
  final double pointRadius;
  final bool showInput;

  final Paint circlePaint;
  final Paint selectedPaint;

  _LockPainter({
    required this.dimension,
    required this.used,
    this.currentPoint,
    required this.relativePadding,
    required Color selectedColor,
    required Color notSelectedColor,
    required this.pointRadius,
    required this.showInput,
    required bool fillPoints,
  })  : circlePaint = Paint()
          ..color = notSelectedColor
          ..style = fillPoints ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeWidth = 2,
        selectedPaint = Paint()
          ..color = selectedColor
          ..style = fillPoints ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    Offset circlePosition(int n) => calcCirclePosition(n, size, dimension, relativePadding);

    for (int i = 0; i < dimension; ++i) {
      for (int j = 0; j < dimension; ++j) {
        canvas.drawCircle(
          circlePosition(i * dimension + j),
          pointRadius,
          showInput && used.contains(i * dimension + j) ? selectedPaint : circlePaint,
        );
      }
    }

    if (showInput) {
      for (int i = 0; i < used.length - 1; ++i) {
        canvas.drawLine(
          circlePosition(used[i]),
          circlePosition(used[i + 1]),
          selectedPaint,
        );
      }

      final currentPoint = this.currentPoint;
      if (used.isNotEmpty && currentPoint != null) {
        canvas.drawLine(
          circlePosition(used[used.length - 1]),
          currentPoint,
          selectedPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

Offset calcCirclePosition(int n, Size size, int dimension, double relativePadding) {
  final o = size.width > size.height ? Offset((size.width - size.height) / 2, 0) : Offset(0, (size.height - size.width) / 2);
  return o +
      Offset(
        size.shortestSide / (dimension - 1 + relativePadding * 2) * (n % dimension + relativePadding),
        size.shortestSide / (dimension - 1 + relativePadding * 2) * (n ~/ dimension + relativePadding),
      );
}
