import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/generated/assets.dart';

import 'logic.dart';

class ActivityDetailPage extends StatelessWidget {
  ActivityDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(ActivityDetailLogic());

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
  Widget _buildView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('活动详情'),
        leading:  IconButton(
          icon: Image.asset(
            Assets.systemIconBack,
            width: 20.w,
            height: 20.w),
          onPressed: () {
              Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
                Assets.systemIconShare,
                width: 20.w,
                height: 20.w),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      Assets.activityActivityDetail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox( height: 20.w),
                SizedBox(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      Assets.activityActivityDetail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
