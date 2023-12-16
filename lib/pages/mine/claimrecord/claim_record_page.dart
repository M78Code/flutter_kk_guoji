import 'package:flutter/material.dart';

class ClaimRecordPage extends StatelessWidget {
  const ClaimRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '领取记录',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
            padding: const EdgeInsets.all(16),
            iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_normal.png')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      //在AppBar下方添加一条白色线
                      color: Color.fromRGBO(255, 255, 255, 0.06),
                      width: 1))),
        ),
        actions: const [
          Text(
            '88888888   ',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
