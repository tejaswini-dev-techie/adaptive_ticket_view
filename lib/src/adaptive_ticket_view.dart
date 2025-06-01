import 'dart:math';
import 'package:flutter/material.dart';

/// The style of the separator line in the ticket.
enum TicketLineStyle {
  /// No separator line
  none,

  /// Dotted separator line
  dotted,

  /// Solid separator line
  solid,
}

/// A customizable ticket widget that creates a beautiful ticket view with dynamic content.
///
/// The [AdaptiveTicketView] widget provides a customizable ticket layout with:
/// * Customizable background and border colors
/// * Dynamic content area
/// * Optional bottom message and ticket code
/// * Customizable line style (none, dotted, or solid)
///
/// Example:
/// ```dart
/// AdaptiveTicketView(
///   ticketBgColor: Colors.blue[100]!,
///   ticketBorderColor: Colors.blue,
///   ticketInfoWidget: YourCustomContent(),
///   ticketBottomMessage: "Enjoy your journey!",
///   ticketCode: "123456789",
///   lineStyle: TicketLineStyle.dotted,
/// )
/// ```
class AdaptiveTicketView extends StatefulWidget {
  /// The background color of the ticket
  final Color ticketBgColor;

  /// The border color of the ticket
  final Color ticketBorderColor;

  /// The main content widget to be displayed in the ticket
  final Widget? ticketInfoWidget;

  /// Optional message to be displayed at the bottom of the ticket
  final String? ticketBottomMessage;

  /// Optional ticket code to be displayed at the bottom
  final String? ticketCode;

  /// The style of the separator line
  final TicketLineStyle lineStyle;

  /// Color of the separator line
  final Color lineColor;

  /// Creates an [AdaptiveTicketView] widget.
  const AdaptiveTicketView({
    super.key,
    required this.ticketBorderColor,
    required this.ticketBgColor,
    this.ticketInfoWidget,
    this.ticketBottomMessage,
    this.ticketCode,
    this.lineStyle = TicketLineStyle.dotted,
    this.lineColor = const Color(0xff0077b6),
  });

  @override
  State<AdaptiveTicketView> createState() => _AdaptiveTicketViewState();
}

class _AdaptiveTicketViewState extends State<AdaptiveTicketView> {
  final GlobalKey ticketContentKey = GlobalKey();
  double contentHeight = 0.0;
  ValueNotifier<bool> updateTicket = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      contentHeight = _calculateContentHeight();
      updateContentHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      contentHeight = constraints.maxHeight;

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ValueListenableBuilder(
          valueListenable: updateTicket,
          builder: (context, bool val, _) {
            return CustomPaint(
              painter: TicketPainter(
                borderColor: widget.ticketBorderColor,
                bgColor: widget.ticketBgColor,
                lineColor: widget.lineColor,
                contentHeight: _calculateContentHeight(),
                lineStyle: widget.lineStyle,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      key: ticketContentKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          if (widget.ticketInfoWidget != null)
                            widget.ticketInfoWidget ?? const SizedBox.shrink(),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                    if (widget.ticketBottomMessage != null ||
                        widget.ticketCode != null) ...[
                      const SizedBox(height: 38.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 20.0),
                          if (widget.ticketBottomMessage != null)
                            Text(
                              widget.ticketBottomMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          if (widget.ticketCode != null) ...[
                            const SizedBox(height: 8.0),
                            Text(
                              widget.ticketCode!,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  double _calculateContentHeight() {
    double contentHeight = 0.0;
    if (ticketContentKey.currentContext != null) {
      final contentSize =
          ticketContentKey.currentContext!.findRenderObject()!.paintBounds.size;
      contentHeight = contentSize.height;
      updateTicket.value = !updateTicket.value;
    }
    return contentHeight;
  }

  void updateContentHeight() {
    setState(() {
      contentHeight = _calculateContentHeight();
    });
  }
}

/// Custom painter class to draw the ticket shape with cutouts and separator line.
class TicketPainter extends CustomPainter {
  final Color borderColor;
  final Color bgColor;
  final Color lineColor;
  final double contentHeight;
  final TicketLineStyle lineStyle;

  static const _cornerGap = 16.0;
  static const _cutoutRadius = 19.0;
  static const _cutoutDiameter = _cutoutRadius * 2.0;

  TicketPainter({
    required this.bgColor,
    required this.borderColor,
    required this.lineColor,
    required this.contentHeight,
    required this.lineStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final maxWidth = size.width;
    final maxHeight = size.height;

    final cutoutStartPos = contentHeight + _cutoutRadius + 47.0;
    final leftCutoutStartY = cutoutStartPos;
    final rightCutoutStartY = cutoutStartPos - _cutoutDiameter;
    final lineY = cutoutStartPos - _cutoutRadius;
    double lineStartX = _cutoutRadius;

    final double lineEndX = maxWidth - _cutoutRadius;

    final paintBg = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = bgColor;

    final paintBorder = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = borderColor;

    final paintLine = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    var path = Path();

    path.moveTo(_cornerGap, 0);
    path.lineTo(maxWidth - _cornerGap, 0);
    _drawCornerArc(path, maxWidth, _cornerGap);
    path.lineTo(maxWidth, rightCutoutStartY);
    _drawCutout(path, maxWidth, rightCutoutStartY + _cutoutDiameter);
    path.lineTo(maxWidth, maxHeight - _cornerGap);
    _drawCornerArc(path, maxWidth - _cornerGap, maxHeight);
    path.lineTo(_cornerGap, maxHeight);
    _drawCornerArc(path, 0, maxHeight - _cornerGap);
    path.lineTo(0, leftCutoutStartY);
    _drawCutout(path, 0.0, leftCutoutStartY - _cutoutDiameter);
    path.lineTo(0, _cornerGap);
    _drawCornerArc(path, _cornerGap, 0);

    canvas.drawPath(path, paintBg);
    canvas.drawPath(path, paintBorder);

    if (lineStyle != TicketLineStyle.none) {
      if (lineStyle == TicketLineStyle.dotted) {
        final double maxDashWidth = (lineEndX - lineStartX) / 2;
        double maxAllowedDashWidth = 3.0;
        final double dashWidth = min(maxDashWidth, maxAllowedDashWidth);
        double dashSpace = 2.0;

        while (lineStartX < lineEndX) {
          canvas.drawLine(
            Offset(lineStartX, lineY),
            Offset(lineStartX + dashWidth, lineY),
            paintLine,
          );
          lineStartX += dashWidth + dashSpace;
        }
      } else {
        // Draw solid line
        canvas.drawLine(
          Offset(lineStartX, lineY),
          Offset(lineEndX, lineY),
          paintLine,
        );
      }
    }
  }

  void _drawCutout(Path path, double startX, double endY) {
    path.arcToPoint(
      Offset(startX, endY),
      radius: const Radius.circular(_cutoutRadius),
      clockwise: false,
    );
  }

  void _drawCornerArc(Path path, double endPointX, double endPointY) {
    path.arcToPoint(
      Offset(endPointX, endPointY),
      radius: const Radius.circular(_cornerGap),
    );
  }

  @override
  bool shouldRepaint(TicketPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TicketPainter oldDelegate) => false;
}
