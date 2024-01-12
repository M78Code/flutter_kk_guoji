import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/string_util.dart';
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
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset(Assets.imagesIconAccount,
                          width: 18, height: 18.5, fit: BoxFit.cover),
                      SizedBox(width: 15.w),
                      Text("我的账号", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                      const Spacer(),
                      InkWellView(
                          child: Row(
                            children: [
                              Text(controller.userInfoModel?.username ?? "",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                              SizedBox(width: 10.w),
                              Image.asset(Assets.promotionCopy, width: 18.w, height: 18.h),
                            ],
                          ),
                          onPressed: () => StringUtil.clipText(controller.userInfoModel?.username)),
                    ],
                  ),
                  Divider(height: 0.5.h, color: Colors.white.withOpacity(0.3))
                      .marginSymmetric(vertical: 13.h),
                  Row(
                    children: [
                      Image.asset(Assets.imagesPasswordIcon,
                          width: 20.w, height: 20.h, fit: BoxFit.cover),
                      SizedBox(width: 15.w),
                      Text("登录密码", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                      const Spacer(),
                      InkWellView(
                        child: Row(
                          children: [
                            Text("已设置", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                            SizedBox(width: 10.w),
                            Image.asset(Assets.imagesIconArrowsEnter, width: 20.w, height: 20.h),
                          ],
                        ),
                        onPressed: () =>
                            RouteUtil.pushToView(Routes.setLoginPsdPage, arguments: false),
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 15.w),
            ),
          ),
        );
      },
    );
  }
}
