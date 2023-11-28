import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("活动", style: TextStyle(color: Colors.black, fontSize: 18.0),),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
