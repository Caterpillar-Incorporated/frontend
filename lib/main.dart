import 'package:flutter/material.dart';

import 'field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insitnia',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Insitnia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Switch(
            value: state,
            onChanged: (bool value) {
              setState(() {
                state = value;
              });
            },
          ),
          (
            (() {
              switch(state) {
              case false: {
                return const Text('Loser');
              }

              default: {
                return const FootballFieldPlayer(
                  startFrame: 0,
                  endFrame: 5000,
                  metadataName: 'metadata.json',
                );
              }
            }
            })()
          )
        ]
      )
    );
  }
}
