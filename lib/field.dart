import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/model/MatchMetaData.dart';
import 'package:my_flutter_app/model/TrackingInstance.dart';
import 'package:http/http.dart' as http;

import 'painter.dart';

final client = http.Client();

class FootballFieldDisplay extends StatefulWidget {
  const FootballFieldDisplay({super.key, required this.gameId, required this.startFrame, required this.endFrame, required this.metadataName});

  final String gameId;
  final int startFrame;
  final int endFrame;
  final String metadataName;

  @override
  State<FootballFieldDisplay> createState() => FootballFieldState();
}

class FootballFieldState extends State<FootballFieldDisplay> {
  String gameId = "";
  int currentFrame = -1;
  int endFrame = -1;
  bool playing = false;
  int millisecondsBetweenFrames = 10;
  late Timer timer;

  List<TrackingInstance>? trackingInstances;
  MatchMetaData? metadata;

  Future<bool> getTrackingData() async {
    if (trackingInstances == null) {
      gameId = widget.gameId;
      currentFrame = widget.startFrame;
      endFrame = widget.endFrame;

      //db indexed from 1
      int start = currentFrame + 1;
      int end = endFrame + 1;

      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.accessControlAllowOriginHeader: '*',
      };

      final response = await client.get(
        Uri.parse('http://localhost:8080/tracking-data?gameId=$gameId&start=$start&end=$end'), 
        headers: headers
      );

      final result = await json.decode(response.body);
      trackingInstances = List<TrackingInstance>.from(result.map((model) => TrackingInstance.fromJson(model)));
    }

    return true;
  }

  Future<bool> readMetaDataJson() async {
    if (metadata == null) {
      final String response = await rootBundle.loadString('assets/data/${widget.metadataName}');
      final data = await json.decode(response);
      metadata = MatchMetaData.fromJson(data);
    }

    return true;
  }

  Future<List> readData() async {
    return [
      await getTrackingData(),
      await readMetaDataJson()
    ];
  }

  void incrementCurrentFrame() {
    if (playing) {
      setState(() {
        currentFrame < endFrame - 1
          ? currentFrame++
          : playing = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: millisecondsBetweenFrames), (Timer t) => incrementCurrentFrame());
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: readData(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasError) {
          return const Text("An error occurred fetching data :(");
        } else if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator()
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                CustomPaint(
                  foregroundPainter: ShapePainter(
                      trackingInstance: trackingInstances![currentFrame],
                      metadata: metadata!
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/FootballField.jpg',
                    ),
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow_outlined),
                      tooltip: playing ? "Pause": "Play",
                      onPressed: () {
                        setState(() {
                          playing = !playing;
                        });
                      },
                    ),
                    Slider(
                      value: currentFrame.toDouble(),
                      min: 0,
                      max: (endFrame - 1),
                      divisions: endFrame,
                      onChanged: (double value) {
                        if (!playing) {
                          setState(() {
                            currentFrame = value.toInt();
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.restart_alt),
                      tooltip: "Go to beginning",
                      onPressed: () {
                        setState(() {
                          currentFrame = 0;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      value: millisecondsBetweenFrames.toString(),
                      onChanged: (String? value) {
                        timer.cancel();
                        setState(() {
                          millisecondsBetweenFrames = int.parse(value!);
                        });
                        timer = Timer.periodic(Duration(milliseconds: millisecondsBetweenFrames), (Timer t) => incrementCurrentFrame());
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "20",
                          child: Text("x0.5")
                        ),
                        DropdownMenuItem(
                          value: "10",
                          child: Text("x1.0")
                        ),
                        DropdownMenuItem(
                          value: "7.5",
                          child: Text("x1.5")
                        ),
                        DropdownMenuItem(
                          value: "5",
                          child: Text("x2.0")
                        ),
                      ]
                    ),
                  ],
                )
              ]
            )
          );
        }
      }
    );
  }
}
