import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/pages/withdraw/withdraw_psd_logic.dart';
import 'package:kkguoji/widget/custom_input_field.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class WithdrawPsdPage extends GetView {
  const WithdrawPsdPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ///Get.arguments true设置提现密码，false修改提现密码
    return GetBuilder(
      init: WithdrawPsdLogic(),
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
                Get.arguments ? "设置提现密码" : "更新提现密码",
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
            // body: Center(),
            body: Center(
              child: ListView(
                children: [
                  SizedBox(height: 20.h),
                  if (!Get.arguments) ...[
                    Text(
                      "请输入旧提现密码",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ).marginOnly(bottom: 10.h),
                    Obx(() {
                      return CustomInputField(null, "请输入旧提现密码",
                          isObscureText: controller.psdObscure1.value,
                          keybordType: TextInputType.number,
                          maxLength: 6,
                          rightWidget: GestureDetector(
                            child: SizedBox(
                              width: 60,
                              child: Image.asset(
                                controller.psdObscure1.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                                width: 30,
                                height: 30,
                              ),
                            ),
                            onTap: () {
                              controller.showPassword(controller.psdObscure1);
                            },
                          ),
                          valueChanged: (value) => controller.inputPasswordValue(value, 0));
                    }),
                    SizedBox(height: 20.h)
                  ],
                  Text(
                    Get.arguments ? "请输入提现密码" : "请输入新提现密码",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ).marginOnly(bottom: 10.h),
                  Obx(() {
                    return CustomInputField(null, Get.arguments ? "请输入6位纯数字密码" : "请输入新6位纯数字密码",
                        isObscureText: controller.psdObscure2.value,
                        keybordType: TextInputType.number,
                        maxLength: 6,
                        rightWidget: GestureDetector(
                          child: SizedBox(
                            width: 60,
                            child: Image.asset(
                              controller.psdObscure2.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          onTap: () {
                            controller.showPassword(controller.psdObscure2);
                          },
                        ),
                        valueChanged: (value) => controller.inputPasswordValue(value, 1));
                  }),
                  Text(
                    Get.arguments ? "请再次输入提现密码" : "请再次输入新提现密码",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ).marginOnly(bottom: 10.h, top: 20.h),
                  Obx(() {
                    return CustomInputField(null, "请再次输入6位纯数字密码",
                        isObscureText: controller.psdObscure3.value,
                        keybordType: TextInputType.number,
                        maxLength: 6,
                        rightWidget: GestureDetector(
                          child: SizedBox(
                            width: 60,
                            child: Image.asset(
                              controller.psdObscure3.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          onTap: () {
                            controller.showPassword(controller.psdObscure3);
                          },
                        ),
                        valueChanged: (value) => controller.inputPasswordValue(value, 2));
                  }),
                  Row(
                    children: [
                      Image.asset(Assets.imagesTipStar, width: 9.w, height: 22.h).marginOnly(right: 5.w),
                      Text(
                        "注意: 如忘记原密码，请联系客服",
                        style: TextStyle(color: const Color(0xffA19DBD), fontSize: 14.sp),
                      ),
                    ],
                  ).marginOnly(top: 20.h, bottom: 30.h),
                  buttonSubmit(
                    height: 50.h,
                    onPressed: () => controller.setPsdSubmit(Get.arguments),
                    text: "确认",
                  )
                ],
              ).paddingSymmetric(horizontal: 15.w),
            ),
          ),
        );
      },
    );
  }
}
