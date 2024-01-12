import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html2md/html2md.dart' as html2md;


class NoticeWidget extends StatefulWidget {
  Map noticeInfo;
  NoticeWidget(this.noticeInfo,{super.key});

  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 317.w,
        height: 387.w,
        decoration: BoxDecoration(
          color: const Color(0xFF2E374C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 30,width: 30,),
                const Text("系统通知", style: TextStyle(color: Colors.white, fontSize: 16),),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(onPressed: (){
                    Get.back(result: isSelected);
                  }, icon: const Icon(Icons.close, size: 20,)),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Image.network(widget.noticeInfo["image"], height: 150,),
            const SizedBox(height: 20,),
            Text(html2md.convert(widget.noticeInfo["content"]),
              style: const TextStyle(color: Colors.white, fontSize: 14),),
            const SizedBox(height: 15,),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(isSelected?Assets.homeNoticeSeleced: Assets.homeNoticeNormal, width: 22, height: 22,),
                  SizedBox(width: 5,),
                  const Text("今日不再弹出", style: TextStyle(color: Colors.blueGrey, fontSize: 14),)

                ],
              ),
              onTap: () {
                setState(() {
                   isSelected = !isSelected;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
