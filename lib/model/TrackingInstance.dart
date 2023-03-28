import 'dart:convert';

TrackingInstance trackingInstance(String str) =>
    TrackingInstance.fromJson(json.decode(str));

String trackingInstanceToJson(TrackingInstance data) =>
    json.encode(data.toJson());

class TrackingInstance {
  TrackingInstance({
    required this.period,
    required this.frameIdx,
    required this.gameClock,
    required this.wallClock,
    required this.homePlayers,
    required this.awayPlayers,
    required this.ball,
    required this.live,
    required this.lastTouch,
  });

  int period;
  int frameIdx;
  double gameClock;
  int wallClock;
  List<Player> homePlayers;
  List<Player> awayPlayers;
  Ball ball;
  bool live;
  String lastTouch;

  factory TrackingInstance.fromJson(Map<String, dynamic> json) =>
      TrackingInstance(
        period: json["period"],
        frameIdx: json["frameIdx"],
        gameClock: json["gameClock"],
        wallClock: json["wallClock"],
        homePlayers: List<Player>.from(
            json["homePlayers"].map((x) => Player.fromJson(x))),
        awayPlayers: List<Player>.from(
            json["awayPlayers"].map((x) => Player.fromJson(x))),
        ball: Ball.fromJson(json["ball"]),
        live: json["live"],
        lastTouch: json["lastTouch"],
      );

  Map<String, dynamic> toJson() =>
      {
        "period": period,
        "frameIdx": frameIdx,
        "gameClock": gameClock,
        "wallClock": wallClock,
        "homePlayers": List<dynamic>.from(homePlayers.map((x) => x.toJson())),
        "awayPlayers": List<dynamic>.from(awayPlayers.map((x) => x.toJson())),
        "ball": ball.toJson(),
        "live": live,
        "lastTouch": lastTouch,
      };
}

class Player {
  Player({
    required this.playerId,
    required this.number,
    required this.xyz,
    required this.speed,
    required this.optaId,
  });

  String playerId;
  int number;
  List<double> xyz;
  double speed;
  String optaId;

  factory Player.fromJson(Map<String, dynamic> json) =>
      Player(
        playerId: json["playerId"],
        number: json["number"],
        xyz: List<double>.from(json["xyz"].map((x) => x?.toDouble())),
        speed: json["speed"],
        optaId: json["optaId"],
      );

  Map<String, dynamic> toJson() =>
      {
        "playerId": playerId,
        "number": number,
        "xyz": List<dynamic>.from(xyz.map((x) => x)),
        "speed": speed,
        "optaId": optaId,
      };
}

class Ball {
  Ball({
    required this.xyz,
    required this.speed,
  });

  List<double> xyz;
  double speed;

  factory Ball.fromJson(Map<String, dynamic> json) =>
      Ball(
        xyz: List<double>.from(json["xyz"].map((x) => x?.toDouble())),
        speed: json["speed"]?.toDouble(),
      );

  Map<String, dynamic> toJson() =>
      {
        "xyz": List<dynamic>.from(xyz.map((x) => x)),
        "speed": speed,
      };
}
