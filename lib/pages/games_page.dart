import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("游戏", style: TextStyle(color: Colors.black, fontSize: 18.0),),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
