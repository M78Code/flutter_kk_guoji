import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TestPagePage extends StatelessWidget {
  TestPagePage({Key? key}) : super(key: key);

  final logic = Get.put(TestPageLogic());
  final state = Get.find<TestPageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
