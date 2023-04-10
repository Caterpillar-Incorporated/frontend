import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/gameSelectionScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameSelectionScreen()),
                );
              }, 
              child: const Text("Game Selector")
            )
          ]
        )
      )
    );
  }

}