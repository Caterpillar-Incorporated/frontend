import 'package:flutter/material.dart';
import 'package:my_flutter_app/model/MatchMetaData.dart' as md;
import 'package:my_flutter_app/model/TrackingInstance.dart';

class ShapePainter extends CustomPainter {
  ShapePainter({required this.trackingInstance, required this.metadata});

  TrackingInstance trackingInstance;
  md.MatchMetaData metadata;

  @override
  void paint(Canvas canvas, Size size) {
    var homePaint = Paint()
      ..color = const Color.fromARGB(255, 0, 63, 56)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    var awayPaint = Paint()
      ..color = const Color.fromARGB(255, 118, 44, 121)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    var ballPaint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    drawTeamCircles(canvas, homePaint, trackingInstance.homePlayers, size);
    drawTeamCircles(canvas, awayPaint, trackingInstance.awayPlayers, size);
    drawBall(canvas, ballPaint, trackingInstance.ball, size);
  }

  void drawTeamCircles(Canvas canvas, Paint paint, List<Player> players,
      Size size) {
    for (var player in players) {
      /*
      
      take x from middle and subtract half of the length of the field

      divide outcome by entire length of field

      take fraction and multiply size of the picture by it

      */
      double x = size.width * (player.xyz[0] + (metadata.pitchLength / 2)) /
          metadata.pitchLength;
      double y = size.height * (player.xyz[1] + (metadata.pitchWidth / 2)) /
          metadata.pitchWidth;

      Offset startingPoint = Offset(x, y);

      canvas.drawCircle(startingPoint, 5, paint);
    }
  }

  void drawBall(Canvas canvas, Paint paint, Ball ball, Size size) {
    double x = size.width * (ball.xyz[0] + (metadata.pitchLength / 2)) /
        metadata.pitchLength;
    double y = size.height * (ball.xyz[1] + (metadata.pitchWidth / 2)) /
        metadata.pitchWidth;

    Offset startingPoint = Offset(x, y);

    canvas.drawCircle(startingPoint, 5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}