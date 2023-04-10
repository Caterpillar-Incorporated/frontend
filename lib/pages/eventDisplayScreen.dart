import 'package:flutter/material.dart';
import 'package:my_flutter_app/field.dart';

class EventDisplayScreen extends StatelessWidget {
  const EventDisplayScreen({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back to Game Selection",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FootballFieldDisplay(
              gameId: gameId,
              startFrame: 0,
              endFrame: 5000,
              metadataName: 'metadata.json',
            )
          ]
        )
      )
    );
  }

}