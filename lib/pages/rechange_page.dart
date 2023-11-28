import 'package:flutter/material.dart';

class RechangePage extends StatelessWidget {
  const RechangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("充值", style: TextStyle(color: Colors.black, fontSize: 18.0),),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
