import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final double position;
  final double duration;

  WaveformPainter({required this.position, required this.duration});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue.withOpacity(0.6);
    final backgroundPaint = Paint()..color = Colors.grey.withOpacity(0.3);
    final path = Path();

    // Draw background waveform (static)
    for (double i = 0; i < size.width; i++) {
      path.lineTo(i, size.height / 2 + (i % 20) * 5 * (i % 2 == 0 ? 1 : -1)); // Create waveform effect
    }

    // Draw the static background waveform
    canvas.drawPath(path, backgroundPaint);

    // Draw active progress (dynamic part representing current playback position)
    final activePath = Path();
    for (double i = 0; i < size.width; i++) {
      double progress = (i / size.width) * duration;
      if (progress <= position) {
        activePath.lineTo(i, size.height / 2 + (i % 20) * 5 * (i % 2 == 0 ? 1 : -1));
      } else {
        activePath.moveTo(i, size.height / 2);
      }
    }
    canvas.drawPath(activePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
