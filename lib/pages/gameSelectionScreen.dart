import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/eventDisplayScreen.dart';

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Game"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back to Home",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventDisplayScreen(gameId: "g2312135")),
                );
              }, 
              child: const Text("View Event")
            )
          ]
        )
      )
    );
  }

}