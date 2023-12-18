import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_logic.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/utils/image_util.dart';
import 'package:kkguoji/widget/inkwell_view.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class MyAccountPage extends GetView<MyAccountLogic> {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: MyAccountLogic(),
      builder: (controller) {
        return KeyboardDissmissable(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset(
                  Assets.imagesBackNormal,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              title: Text(
                "我的账号",
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
            // body: Center(),
            body: Center(
              child: Column(
                children: [
                  _buildAvatar(),
                  SizedBox(height: 40.h),
                  _buildAvatarList(context),
                  _buildConfirm(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 40.r,
                    backgroundImage: AssetImage(controller.selectedImg.value),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "用户昵称",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            InkWellView(
              child: Image.asset(
                Assets.myaccountIconEdit,
                width: 24.w,
                height: 24.h,
              ),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }

  Widget _buildAvatarList(BuildContext context) {
    return Wrap(
      spacing: 20.w,
      runSpacing: 15.h,
      children: List.generate(
        controller.avatarList.length,
        (index) {
          final pair = controller.avatarList[index];
          return Obx(
            () => Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: controller.selectedIndex.value == pair.first ? const Color(0xff70BAFF) : Colors.transparent, //圆环颜色
                    width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    if (pair.first == 7) {
                      //打开摄像头
                      ImageUtil.requestCamera(
                        context,
                        callback: (result) => controller.updateCamera(result),
                      );
                    } else {
                      controller.updateIndex(index);
                    }
                  },
                  child: CircleAvatar(
                    radius: 32.r,
                    backgroundImage: AssetImage(pair.third),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConfirm() {
    return Container(
      margin: EdgeInsets.only(top: 35.h),
      child: buttonSubmit(
        text: "确定",
        height: 55,
        hPadding: 25.w,
        onPressed: () {
          // controller.recharge();
        },
      ),
    );
  }
}
