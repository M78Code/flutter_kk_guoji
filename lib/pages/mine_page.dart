import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的", style: TextStyle(color: Colors.black, fontSize: 18.0),),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
