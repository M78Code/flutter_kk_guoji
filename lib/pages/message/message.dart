import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/list/activity_logic.dart';
import 'package:kkguoji/pages/activity/list/widgets/item_widget.dart';

class MessageCenterPage extends StatefulWidget {
  const MessageCenterPage({super.key});

  @override
  State<MessageCenterPage> createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息中心'),
        leading: IconButton(
            padding: const EdgeInsets.all(16.0),
            iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_normal.png')),
      ),
      body: Container(
        child: const Column(
          children: [
            Text(
              'dddd',
              style: TextStyle(color: Colors.white),
            ),
            SelectionbarView(),
          ],
        ),
      ),
    );
  }
}

class SelectionbarView extends StatefulWidget {
  const SelectionbarView({super.key});

  @override
  State<SelectionbarView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SelectionbarView> {
  // ignore: unused_local_variable
  int selectedIndex = 0; // 默认选中
  // ignore: unused_local_variable
  List itemList = [
    {'title': '全部活动'},
    {'title': '通知活动'},
    {'title': '系统公告'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList.length,
        itemBuilder: (content, index) {
          return Container(
            color: Colors.black,
            margin: const EdgeInsets.all(10),
            height: 30,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFF3D35C6)),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${itemList[index]['title']}',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          );
        });
  }
}
