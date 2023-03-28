import 'dart:convert';

MatchMetaData matchMetaDataFromJson(String str) =>
    MatchMetaData.fromJson(json.decode(str));

String matchMetaDataToJson(MatchMetaData data) => json.encode(data.toJson());

class MatchMetaData {
  MatchMetaData({
    this.venueId,
    required this.description,
    required this.startTime,
    required this.year,
    required this.month,
    required this.day,
    required this.pitchLength,
    required this.pitchWidth,
    required this.fps,
    required this.periods,
    required this.homePlayers,
    required this.awayPlayers,
    required this.homeScore,
    required this.awayScore,
    required this.ssiId,
    required this.optaId,
    this.optaUuid,
    required this.tracksVersion,
    required this.homeSsiId,
    required this.homeOptaId,
    required this.homeOptaUuid,
    required this.awaySsiId,
    required this.awayOptaId,
    this.awayOptaUuid,
  });

  dynamic venueId;
  String description;
  int startTime;
  int year;
  int month;
  int day;
  double pitchLength;
  double pitchWidth;
  double fps;
  List<Period> periods;
  List<Player> homePlayers;
  List<Player> awayPlayers;
  int homeScore;
  int awayScore;
  String ssiId;
  String optaId;
  dynamic optaUuid;
  int tracksVersion;
  String homeSsiId;
  String homeOptaId;
  String homeOptaUuid;
  String awaySsiId;
  String awayOptaId;
  dynamic awayOptaUuid;

  factory MatchMetaData.fromJson(Map<String, dynamic> json) =>
      MatchMetaData(
        venueId: json["venueId"],
        description: json["description"],
        startTime: json["startTime"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        pitchLength: json["pitchLength"]?.toDouble(),
        pitchWidth: json["pitchWidth"]?.toDouble(),
        fps: json["fps"],
        periods: List<Period>.from(
            json["periods"].map((x) => Period.fromJson(x))),
        homePlayers: List<Player>.from(
            json["homePlayers"].map((x) => Player.fromJson(x))),
        awayPlayers: List<Player>.from(
            json["awayPlayers"].map((x) => Player.fromJson(x))),
        homeScore: json["homeScore"],
        awayScore: json["awayScore"],
        ssiId: json["ssiId"],
        optaId: json["optaId"],
        optaUuid: json["optaUuid"],
        tracksVersion: json["tracksVersion"],
        homeSsiId: json["homeSsiId"],
        homeOptaId: json["homeOptaId"],
        homeOptaUuid: json["homeOptaUuid"],
        awaySsiId: json["awaySsiId"],
        awayOptaId: json["awayOptaId"],
        awayOptaUuid: json["awayOptaUuid"],
      );

  Map<String, dynamic> toJson() =>
      {
        "venueId": venueId,
        "description": description,
        "startTime": startTime,
        "year": year,
        "month": month,
        "day": day,
        "pitchLength": pitchLength,
        "pitchWidth": pitchWidth,
        "fps": fps,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "homePlayers": List<dynamic>.from(homePlayers.map((x) => x.toJson())),
        "awayPlayers": List<dynamic>.from(awayPlayers.map((x) => x.toJson())),
        "homeScore": homeScore,
        "awayScore": awayScore,
        "ssiId": ssiId,
        "optaId": optaId,
        "optaUuid": optaUuid,
        "tracksVersion": tracksVersion,
        "homeSsiId": homeSsiId,
        "homeOptaId": homeOptaId,
        "homeOptaUuid": homeOptaUuid,
        "awaySsiId": awaySsiId,
        "awayOptaId": awayOptaId,
        "awayOptaUuid": awayOptaUuid,
      };
}

class Player {
  Player({
    required this.name,
    required this.number,
    required this.position,
    required this.ssiId,
    this.optaId,
    this.optaUuid,
  });

  String name;
  int number;
  Position position;
  String ssiId;
  String? optaId;
  String? optaUuid;

  factory Player.fromJson(Map<String, dynamic> json) =>
      Player(
        name: json["name"],
        number: json["number"],
        position: positionValues.map[json["position"]]!,
        ssiId: json["ssiId"],
        optaId: json["optaId"],
        optaUuid: json["optaUuid"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "number": number,
        "position": positionValues.reverse[position],
        "ssiId": ssiId,
        "optaId": optaId,
        "optaUuid": optaUuid,
      };
}

enum Position { GK, DF, MF, FW, SUB }

final positionValues = EnumValues({
  "DF": Position.DF,
  "FW": Position.FW,
  "GK": Position.GK,
  "MF": Position.MF,
  "SUB": Position.SUB
});

class Period {
  Period({
    required this.number,
    required this.startFrameClock,
    required this.endFrameClock,
    required this.startFrameIdx,
    required this.endFrameIdx,
    required this.homeAttPositive,
  });

  int number;
  int startFrameClock;
  int endFrameClock;
  int startFrameIdx;
  int endFrameIdx;
  bool homeAttPositive;

  factory Period.fromJson(Map<String, dynamic> json) =>
      Period(
        number: json["number"],
        startFrameClock: json["startFrameClock"],
        endFrameClock: json["endFrameClock"],
        startFrameIdx: json["startFrameIdx"],
        endFrameIdx: json["endFrameIdx"],
        homeAttPositive: json["homeAttPositive"],
      );

  Map<String, dynamic> toJson() =>
      {
        "number": number,
        "startFrameClock": startFrameClock,
        "endFrameClock": endFrameClock,
        "startFrameIdx": startFrameIdx,
        "endFrameIdx": endFrameIdx,
        "homeAttPositive": homeAttPositive,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
